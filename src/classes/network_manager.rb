class NetworkManager

	def initialize nodes, networks
		@networks = networks
		@nodes = nodes
	end

	def send_message src, dst, msg
		@nodes[src].send_message @nodes[dst], msg
	end

end
