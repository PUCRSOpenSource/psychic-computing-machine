require './interface.rb'
class Node
	attr_reader :name
	attr_reader :gateway
	attr_reader :interface
	def initialize(name, gateway, interface)
		@name = name
		@gateway = gateway
		@interface = interface
	end
end
