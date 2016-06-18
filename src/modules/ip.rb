module Ip

	def addr_to_dec addr
		addr.split('.').inject(0) { |total,value| (total << 8 ) + value.to_i }
	end

	def dec_to_addr num
		[24, 16, 8, 0].collect { |b| (num >> b) & 255 }.join('.')
	end

	def addr_to_network ip, prefix
		addr_dec = addr_to_dec ip
		net_dec = (0xFFFFFFFF << (32 - prefix)) & addr_dec
		dec_to_addr net_dec
	end

	def network_class net_address
		ip_bin = "%.32b" % addr_to_dec(net_address)
		return 'A' if ip_bin[0] == '0'
		return 'B' if ip_bin[1] == '0'
		return 'C'
	end

end
