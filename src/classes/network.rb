require_relative '../modules/ip'

class Network

	include Ip

	attr_reader :address
	attr_reader :interfaces
	attr_reader :class

	def initialize address
		@address    = address
		@interfaces = []
	end

end
