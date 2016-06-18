class Router
	attr_accessor :interfaces
	attr_accessor :router_table
	def initialize
		@router_table = {}
	end
end
