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

	def send_message dst, msg
		dg = Datagram.new @ip, dst.ip, name, dst.name, msg
		same_network = @network.address == dec_to_addr(addr_to_dec(dst.ip) & network_mask(dst.ip))
		dst = if same_network then dst else @network.search_by_ip(gateway) end
		dg = Datagram.new @ip, dst.ip, name, dst.name, nil, dg unless same_network
		arp_request dst.ip
		icmp_request dg
	end

end
