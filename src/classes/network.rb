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
		mac = ''
		interfaces.each do |interface|
			reply = interface.arp_reply ip_dst, mac_src, name_src
			mac = reply until reply.nil?
		end
		return mac
	end

end
