class Interface

	attr_reader :mac
	attr_reader :mtu
	attr_reader :ip
	attr_reader :name
	attr_accessor :network
	attr_reader :arp_table

	def initialize name, mac, ip, mtu
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
		@arp_table[ip_dst] = dst_mac if @arp_table[ip_dst].nil?
		if ip_dst == @ip
			puts "#{@name} => #{dst_name} : ARP - #{@ip} is at #{@mac};"
			return @mac
		end
		return
	end

	def icmp_request ip_dst, name_dst, message, ttl
		puts "#{@name} => #{name_dst} : ICMP - Echo (ping) request (src=#{@ip} dst=#{ip_dst} ttl=#{ttl} data=#{message});"
		@network.icmp_request ip_dst, name_dst, message, ttl, @ip, @name
	end

	def icmp_reply ip_dst, name_dst, message, ttl, ip_src, name_src, last
		if ip_dst == @ip
			icmp_echo message
			unless last
				puts "#{@name} => #{name_src} : ICMP - Echo (ping) reply (src=#{@ip} dst=#{ip_src} ttl=#{ttl} data=#{message});"
				@network.icmp_reply(ip_src, @ip, name_dst, message, ttl, @name, true)
			end
		end
		return
	end

	def icmp_echo message
		puts "#{@name} rbox #{@name} : Received #{message};"
	end

	def send_message dst, msg
		arp_request  dst.ip
		icmp_request dst.ip, dst.name, msg, 8
	end

end
