require 'rspec'
require 'faker'

require_relative '../interface.rb'

describe Interface do
	before :each do
		@mtu = Faker::Number.number(8)
		@mac = Faker::Internet.mac_address
		@ip  = Faker::Internet.ip_v4_address
		@interface = Interface.new(@mac, @mtu, @ip)
	end
	describe '#new' do
		it 'takes three parameters and return a Interfac object' do
			expect(@interface).to be_an_instance_of(Interface)
		end
	end
end
