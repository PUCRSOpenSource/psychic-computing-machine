require_relative 'interface'
require_relative '../modules/ip'

class Node < Interface

	include Ip

	attr_reader :gateway

	def initialize(name, mac, ip, mtu, gateway)
		super(name, mac, ip, mtu)
		@gateway = gateway
	end

	def arp_request ip_dst
		if @network.address == (addr_to_dec(ip_dst) & network_mask(ip_dst))
			puts "#{@name} box #{@name} : ARP - Who has #{ip_dst}? Tell #{@ip};"
			reply = @network.arp_request ip_dst, @mac, @name
			@arp_table[ip_dst] = reply
		else
			puts "#{@name} box #{@name} : ARP - Who has #{gateway}? Tell #{@ip};"
			reply = @network.arp_request gateway, @mac, @name
			@arp_table[gateway] = reply
		end
	end

end
