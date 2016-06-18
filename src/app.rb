Dir['classes/*.rb'].each do |file|
	require_relative file
end

counter = 0
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
			interface = Interface.new(line[1], line[2], line[3])
			node      = Node.new(line[0], line[4], interface)
			nodes[line[0]] = node
		when 2 #when reading router
			interfaces = Array.new
			name  = line[0]
			ports = line[1].to_i
			line.shift(2)
			ports.times do |x|
				mac, ip, mtu = line.shift 3
				puts "#{mac} #{ip} #{mtu}"
				interface    = Interface.new(mac, ip, mtu)
				interfaces.push(interface)
			end
			router   = Router.new(name, ports, interfaces)
			routers[name] = router
		when 3 #when reading routertable
			net_addr = line[1]
			if networks[net_addr].nil?
				network = Network.new net_addr
				networks[net_addr] = network
			end
			routers[line[0]].routes.push(line[1,3])
		end
	end
	net_addr = ''
	nodes.each_pair do |name, node| 
		net_addr = node.interface.ip.split('.')
		net_addr[-1] = '0'
		net_addr = net_addr.join('.')
		node.network = networks[net_addr]
		networks[net_addr].add_node(name, node.interface)
	end
	puts networks
end

src = nodes[ARGV[1]]
dst = nodes[ARGV[2]]
msg = ARGV[3]

src.send_message(ARGV[2], msg)
