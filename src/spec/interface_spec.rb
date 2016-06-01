require 'rspec'
require 'faker'

require_relative '../classes/interface.rb'

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
	describe '#mtu' do
		it 'return the correct mtu' do
			expect(@interface.mtu).to eql(@mtu)
		end
	end
	describe '#mac' do
		it 'return the correct mac' do
			expect(@interface.mac).to eql(@mac)
		end
	end
	describe '#ip' do
		it 'return the correct mac' do
			expect(@interface.mac).to eql(@mac)
		end
	end
end
