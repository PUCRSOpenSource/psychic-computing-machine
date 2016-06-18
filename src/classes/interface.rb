class Interface

	attr_reader :mac
	attr_reader :mtu
	attr_reader :ip
	attr_reader :name

	def initialize(mac, ip, mtu, name)
		@mac = mac
		@ip  = ip
		@mtu = mtu
		@name = name
	end
		
	def arp_request
	end
		
	def arp_reply
	end

	def icmp_request
	end

	def icmp_reply
	end

end
