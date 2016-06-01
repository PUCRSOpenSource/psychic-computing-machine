require 'rspec'
require 'faker'

require_relative '../classes/node.rb'

describe Node do
	before :each do
		mtu       = Faker::Number.number(8)
		mac       = Faker::Internet.mac_address
		ip        = Faker::Internet.ip_v4_address
		interface = Interface.new(mac, mtu, ip)

		@gateway  = Faker::Internet.ip_v4_address
		@name     = Faker::Name.first_name
		@node     = Node.new(@name, @gateway, interface)
	end
	describe '#new' do
		it 'takes three parameters and return a Node object' do
			expect(@node).to be_an_instance_of(Node)
		end
	end
	describe '#mtu' do
		it 'return the correct name' do
			expect(@node.name).to eql(@name)
		end
	end
	describe '#gateway' do
		it 'return the correct gateway' do
			expect(@node.gateway).to eql(@gateway)
		end
	end
	describe '#interface' do
		it 'must be an Interface object' do
			expect(@node.interface).to be_an_instance_of(Interface)
		end
	end
end
