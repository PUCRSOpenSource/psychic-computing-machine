class Interface

	attr_reader :mac
	attr_reader :mtu
	attr_reader :ip
	attr_reader :name
	attr_accessor :network
	attr_reader :arp_table

	def initialize(name, mac, ip, mtu)
		@mac = mac
		@ip  = ip
		@mtu = mtu
		@name = name
		@arp_table = {}
	end

	def arp_request ip_dst
		puts "#{@name} box #{@name} : ARP - Who has #{ip_dst}? Tell #{@ip};"
		reply = @network.arp_request ip_dst, @mac, @name
		@arp_table[ip_dst] = reply
	end
		
	def arp_reply ip_dst, dst_mac, dst_name
		@arp_table[ip_dst] = src_mac if @arp_table[ip_dst].nil?
		if ip_dst == @ip
			puts "#{@name} => #{dst_name} : ARP - #{@ip} is at #{@mac};"
			return @mac
		end
	end

	def icmp_request
	end

	def icmp_reply
	end

end
