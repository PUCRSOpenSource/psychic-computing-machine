class Router
	attr_reader :name
	attr_reader :num_ports
	attr_reader :interfaces
	attr_accessor :routes
	def initialize(name, num_ports, interfaces)
		@name       = name
		@num_ports  = num_ports
		@interfaces = interfaces
		@routes = []
	end
end
