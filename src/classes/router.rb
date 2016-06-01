require './interface.rb'

class Router
	attr_reader :name
	attr_reader :num_ports
	attr_reader :interfaces
	def initialize(name, num_ports, interfaces)
		@name       = name
		@num_ports  = num_ports
		@interfaces = interfaces
	end
end
