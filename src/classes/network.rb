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

	def icmp_request ip_dst, name_dst, message, ttl, ip_src, name_src
		interfaces.each do |interface|
			interface.icmp_reply(ip_dst, name_dst, message, ttl, ip_src, name_src, false)
		end
	end

	def icmp_reply ip_dst, ip_src, name_dst, message, ttl, name_src, last
		interfaces.each do |interface|
			interface.icmp_reply ip_dst, ip_src, message, message, ttl, name_src, last
		end
	end

	def search_by_ip ip_address
		interfaces.each do |interface|
			return interface if interface.ip == ip_address
		end
		return nil
	end
end
