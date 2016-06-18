class Network

	attr_reader :address
	attr_reader :interfaces

	def initialize address
		@address    = address
		@interfaces = {}
	end

end
