
require_relative 'datagram'
require_relative '../modules/ip'

class Router

	include Ip

	attr_accessor :interfaces
	attr_accessor :router_table

	def initialize
		@router_table = {}
	end

	def route datagram
		net_address = dec_to_addr(addr_to_dec(datagram.datagram.ip_dst) & network_mask(datagram.datagram.ip_dst))
		rte = router_table['0.0.0.0']
		rte = router_table[net_address] unless router_table[net_address].nil?
		intf = interfaces[rte.port]
		intf.send_message datagram
	end

end
