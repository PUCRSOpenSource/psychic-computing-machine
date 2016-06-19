require_relative '../modules/ip'

class Network

	include Ip

	attr_reader :address
	attr_reader :interfaces
	attr_reader :class

	def initialize address
		@address    = address
		@interfaces = []
	end

	def arp_request ip_dst, mac_src, name_src
		mac = nil
		interfaces.each do |interface|
			reply = interface.arp_reply ip_dst, mac_src, name_src
			mac = reply unless reply.nil?
		end
		return mac
	end

	def icmp_request ip_dst, name_dst, message, ttl
		puts "#{ip_dst} #{name_dst} #{message} #{ttl}"
		interfaces.each do |interface|
			interface.icmp_reply ip_dst, name_dst, message, ttl
		end
	end

end
