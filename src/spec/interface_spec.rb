class Interface
	attr_reader :mac
	attr_reader :mtu
	attr_reader :ip
	def initialize(mac, mtu, ip)
		@mac = mac
		@mtu = mtu
		@ip  = ip
	end
end
