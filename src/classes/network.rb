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

	def icmp_request datagram
		interfaces.each do |interface|
			interface.icmp_reply datagram if interface.ip == datagram.ip_dst
		end
	end

	def icmp_reply datagram
		interfaces.each do |interface|
			interface.icmp_reply datagram if datagram.ip_dst == interface.ip
		end
	end

	def search_by_ip ip_address
		interfaces.each do |interface|
			return interface if interface.ip == ip_address
		end
		return nil
	end
end
