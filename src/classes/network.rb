class Network
	attr_reader :routers
	attr_reader :nodes
	def initialize(routers, nodes)
		@routers = routers
		@nodes = nodes
	end
end
