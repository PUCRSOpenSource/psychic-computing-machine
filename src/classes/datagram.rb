class Datagram

	attr_reader :ip_src
	attr_reader :ip_dst
	attr_reader :name_src
	attr_reader :name_dst
	attr_reader :message
	attr_reader :datagram
	attr_reader :ttl

	def initialize ip_src, ip_dst, name_src, name_dst, message, datagram=nil
		@ip_src = ip_src
		@ip_dst = ip_dst
		@name_src = name_src
		@name_dst = name_dst
		@message = msg
		@datagram = datagram
		@ttl = 8
	end

end
