require_relative 'modules/ip'
Dir['classes/*.rb'].each do |file|
	require_relative file
end

def network_class(net_address)
	include Ip
	ip_dec = Ip::addr_to_dec(net_address)
	ip_bin = "%.32b" % ip_dec
	start = ip_bin[0,3]
	if start[0] == '0'
		return 'A'
	elsif start[1] == '0'
		return 'B'
	else
		return 'C'
	end
end
counter = 0
interfaces = {}
nodes   = {}
networks = {}
routers = {}
rourter_table = []

File.open ARGV[0], "r" do |file|

	file.each_line do |line|
		if line[0] == "#"
			counter += 1
			next
		end

		line = line.chomp.split(',')

		case counter
		when 1 #when reading node
			name, mac, ip, mtu, gateway = line
			Node.new(name, mac, ip, mtu, gateway)
		when 2 #when reading router
			interfaces = Array.new
			name  = line[0]
			ports = line[1].to_i
			line.shift(2)
			ports.times do |x|
				mac, ip, mtu = line.shift 3
				interface    = Interface.new(name, mac, ip, mtu)
				interfaces.push(interface)
			end
			router   = Router.new
			router.interfaces = interfaces
			routers[name] = router
		when 3 #when reading routertable
			name, net_address, netx_hop, port = line
			route = RouterTableEntry.new(netx_hop, port)
			routers[name].router_table[net_address] = route

			if networks[net_address].nil?
				network = Network.new net_address
				networks[net_address] = network
				puts "class: #{network_class(net_address)}"
			end
		end
	end
	#net_addr = ''
	#nodes.each_pair do |name, node| 
		#net_addr = node.interface.ip.split('.')
		#net_addr[-1] = '0'
		#net_addr = net_addr.join('.')
		#node.network = networks[net_addr]
		#networks[net_addr].add_node(name, node.interface)
	#end
	#puts networks
end
