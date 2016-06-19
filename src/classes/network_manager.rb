class NetworkManager

	def initialize nodes, networks
		@networks = networks
		@nodes = nodes
	end

	def send_message src, dst, msg
		x = @nodes[src]
		y = @nodes[dst]
		x.arp_request  y.ip
	end

end
