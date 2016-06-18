require_relative 'interface'

class Node < Interface

	attr_reader :gateway
	attr_reader :interface

	def initialize(name, mac, ip, mtu, gateway)
		super(name, mac, ip, mtu)
		@gateway = gateway
	end

end
