class Datagram

	attr_reader :ip_src
	attr_reader :ip_dst
	attr_reader :msg
	attr_reader :datagram

	def initialize ip_src, ip_dst, msg=nil, datagram=nil
		@ip_src = ip_src
		@ip_dst = ip_dst
		@msg = msg
		@datagram = datagram
	end

end
