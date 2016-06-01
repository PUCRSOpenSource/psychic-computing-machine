class Interface
	attr_reader :mac
	attr_reader :mtu
	attr_reader :ip
	def initialize(mac, ip, mtu)
		@mac = mac
		@ip  = ip
		@mtu = mtu
	end
end
