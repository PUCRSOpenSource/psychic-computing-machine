class Network
	attr_reader :address
	attr_reader :nodes
	attr_reader :router
	def initialize address 
		@address = address
		@nodes = {}
	end

	def add_node node_name, interface
		@nodes[node_name] = interface
	end

	def look_up_node_by_name
		
	end

	def look_up_node_by_ip
		
	end

	def look_up_node_by_mac
		
	end
end
