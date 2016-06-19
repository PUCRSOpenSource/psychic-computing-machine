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

	def icmp_request datagram
		puts "#{@name} => #{datagram.name_dst} : ICMP - Echo (ping) request (src=#{@ip} dst=#{datagram.ip_dst} ttl=#{datagram.ttl} data=#{datagram.get_message});"
		@network.icmp_request datagram
	end

	def icmp_reply datagram
		next_datagram = nil
		if datagram.datagram.nil? || datagram.datagram.ip_dst == @ip
			next_datagram = Datagram.new datagram.ip_dst, datagram.ip_src, datagram.name_dst, datagram.name_src, datagram.message
			next_datagram.reply = true
			icmp_echo datagram.get_message
		else
			router = @network.routers[@name]
			router.route datagram
		end
		unless datagram.reply
			puts "#{@name} => #{datagram.name_src} : ICMP - Echo (ping) reply (src=#{@ip} dst=#{datagram.ip_src} ttl=#{datagram.ttl} data=#{datagram.message});"
			@network.icmp_reply next_datagram
		end
		return
	end

	def icmp_echo message
		puts "#{@name} rbox #{@name} : Received #{message};"
	end

	def send_message datagram
		next_datagram = Datagram.new @ip, datagram.datagram.ip_dst, @name, datagram.datagram.name_dst, nil, datagram.datagram
		arp_request next_datagram.ip_dst
		icmp_request next_datagram
	end

end
