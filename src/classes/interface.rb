require 'pry'

class Interface

	attr_reader :mac
	attr_reader :mtu
	attr_reader :ip
	attr_reader :name
	attr_accessor :network
	attr_reader :arp_table

	def initialize name, mac, ip, mtu
		@mac = mac
		@ip  = ip
		@mtu = mtu
		@name = name
		@arp_table = {}
	end

	def arp_request ip_dst
		if @arp_table[ip_dst].nil?
			puts "#{@name} box #{@name} : ARP - Who has #{ip_dst}? Tell #{@ip};"
			reply = @network.arp_request ip_dst, @mac, @name, @ip
			@arp_table[ip_dst] = reply
		end
	end

	def arp_reply ip_dst, dst_mac, dst_name, ip_src
		@arp_table[ip_src] = dst_mac if @arp_table[ip_src].nil?
		if ip_dst == @ip
			puts "#{@name} => #{dst_name} : ARP - #{@ip} is at #{@mac};"
			return @mac
		end
		return
	end

	def icmp_request datagram
		if datagram.reply
			puts "#{@name} => #{datagram.name_dst} : ICMP - Echo (ping) reply (src=#{datagram.ip_src} dst=#{datagram.ip_dst} ttl=#{datagram.ttl} data=#{datagram.get_message});"
		else
			if is_two_layer_datagram? datagram
				puts "#{@name} => #{datagram.name_dst} : ICMP - Echo (ping) request (src=#{datagram.datagram.ip_src} dst=#{datagram.datagram.ip_dst} ttl=#{datagram.ttl} data=#{datagram.datagram.get_message});"
			else
				puts "#{@name} => #{datagram.name_dst} : ICMP - Echo (ping) request (src=#{datagram.ip_src} dst=#{datagram.ip_dst} ttl=#{datagram.ttl} data=#{datagram.get_message});"
			end
		end
		@network.icmp_request datagram
	end

	def icmp_reply datagram
		router = @network.routers[@name]
		router.route datagram
		return
	end

	def icmp_echo message
		puts "#{@name} rbox #{@name} : Received #{message};"
	end

	def send_message datagram
		ip_dst = datagram.datagram.ip_dst
		name_dst = datagram.datagram.name_dst
		next_network = dec_to_addr(addr_to_dec(datagram.ip_dst) & network_mask(datagram.ip_dst))
		same_network = @network.address == next_network
		if same_network
			next_datagram = Datagram.new datagram.ip_src, ip_dst, @name, name_dst, nil, datagram.datagram
			next_datagram.ttl = datagram.ttl - 1
			next_datagram.reply = true if datagram.reply
		else
			next_network = dec_to_addr(addr_to_dec(datagram.datagram.ip_dst) & network_mask(datagram.datagram.ip_dst))
			#binding.pry
			router_table = @network.routers[@name].router_table
			next_hop = router_table[next_network]
			next_hop = router_table['0.0.0.0'] if next_hop.nil?
			next_hop = next_hop.next_hop

			ip_dst = next_hop unless next_hop == '0.0.0.0'
			name_dst = @network.search_by_ip(ip_dst).name
			next_datagram = Datagram.new datagram.ip_src, ip_dst, @name, name_dst, nil, datagram.datagram
			next_datagram.ttl = datagram.ttl - 1
			next_datagram.reply = true if datagram.reply
		end
		arp_request next_datagram.ip_dst
		icmp_request next_datagram
	end

	private

	def is_two_layer_datagram? datagram
		not datagram.datagram.nil?
	end

	def get_next_hop
		
	end

end
