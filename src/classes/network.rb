class Network
	attr_reader :address
	attr_reader :nodes
	def initialize address 
		@address = address
		@nodes = {}
	end

	def add_node node_name, interface
		@nodes[node_name] = interface
	end
end
