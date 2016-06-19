class Datagram

	attr_reader :ip_src
	attr_reader :ip_dst
	attr_reader :name_src
	attr_reader :name_dst
	attr_reader :msg
	attr_reader :datagram

	def initialize ip_src, ip_dst, name_src, name_dst, msg=nil, datagram=nil
		@ip_src = ip_src
		@ip_dst = ip_dst
		@name_src = name_src
		@name_dst = name_dst
		@msg = msg
		@datagram = datagram
	end

end
