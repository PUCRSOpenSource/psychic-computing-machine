class RouterTableEntry
	attr_reader :next_hop
	attr_reader :port
	def initialize(next_hop, port)
		@next_hop = next_hop
		@port = port
	end
end
