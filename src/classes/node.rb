require_relative 'interface'
require_relative 'datagram'
require_relative '../modules/ip'

class Node < Interface

	include Ip

	attr_reader :gateway

	def initialize(name, mac, ip, mtu, gateway)
		super(name, mac, ip, mtu)
		@gateway = gateway
	end

	def icmp_reply datagram

		if is_two_layer_datagram? datagram
			icmp_echo datagram.datagram.get_message
		else
			icmp_echo datagram.get_message
		end

		unless datagram.reply

			if is_two_layer_datagram? datagram
				puts "#{name} => #{datagram.name_src} : ICMP - Echo (ping) reply (src=#{datagram.ip_dst} dst=#{datagram.ip_src} ttl=#{datagram.ttl} data=#{datagram.datagram.message});"
				next_datagram = Datagram.new datagram.datagram.ip_dst, datagram.datagram.ip_src, datagram.datagram.name_dst, datagram.datagram.name_src, datagram.datagram.message
				next_datagram.reply = true
			else
				puts "#{name} => #{datagram.name_src} : ICMP - Echo (ping) reply (src=#{datagram.ip_dst} dst=#{datagram.ip_src} ttl=#{datagram.ttl} data=#{datagram.message});"
				next_datagram = Datagram.new datagram.ip_dst, datagram.ip_src, datagram.name_dst, datagram.name_src, datagram.message
				next_datagram.reply = true
			end


			##puts "#{name} => #{datagram.name_src} : ICMP - Echo (ping) reply (src=#{datagram.ip_dst} dst=#{datagram.ip_src} ttl=#{datagram.ttl} data=#{datagram.message});"
			##@network.icmp_reply next_datagram

			same_network = @network.address == dec_to_addr(addr_to_dec(next_datagram.ip_dst) & network_mask(next_datagram.ip_dst))
			dst = if same_network then @network.search_by_ip(next_datagram.ip_dst) else @network.search_by_ip(gateway) end
			next_datagram = Datagram.new @ip, dst.ip, name, dst.name, nil, next_datagram unless same_network
			next_datagram.reply = true
			@network.icmp_reply next_datagram


		end
	end

	def send_message dst, msg
		dg = Datagram.new @ip, dst.ip, name, dst.name, msg
		same_network = @network.address == dec_to_addr(addr_to_dec(dst.ip) & network_mask(dst.ip))
		dst = if same_network then dst else @network.search_by_ip(gateway) end
		dg = Datagram.new @ip, dst.ip, name, dst.name, nil, dg unless same_network
		arp_request dst.ip
		icmp_request dg
	end

end
