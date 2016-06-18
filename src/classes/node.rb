class Node
	attr_reader :name
	attr_reader :gateway
	attr_reader :interface
	attr_accessor :network
	def initialize(name, gateway, interface)
		@name = name
		@gateway = gateway
		@interface = interface
	end

	def send_message(dest, message)
		puts "seding to #{dest}: #{message}"
	end
end
