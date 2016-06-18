require_relative 'modules/ip'

class Network

	attr_reader :address
	attr_reader :interfaces
	attr_reader :class

	def initialize address
		@address    = address
		@interfaces = {}
		@class = network_class(address)
	end

	def network_class(net_address)
		include Ip
		ip_dec = Ip::addr_to_dec(net_address)
		ip_bin = "%.32b" % ip_dec
		start = ip_bin[0,3]
		if start[0] == '0'
			return 'A'
		elsif start[1] == '0'
			return 'B'
		else
			return 'C'
		end
	end

end
