
require_relative 'modules/ip'

Dir['classes/*.rb'].each do |file|
	require_relative file
end

puts 'wordwraparcs=true,hscale=2.0;'

def add_to_network(interface, ip, networks)
	include Ip
	net_address = dec_to_addr(addr_to_dec(ip) & network_mask(ip))
	if networks[net_address].nil?
		net = Network.new net_address
		net.interfaces.push interface
		networks[net_address] = net
		interface.network = net
	else
		networks[net_address].interfaces.push interface
		interface.network = networks[net_address]
	end
end

counter   = 0
networks  = {}
routers   = {}
all_nodes = {}

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
			node = Node.new(name, mac, ip, mtu, gateway)
			all_nodes[name] = node
			add_to_network(node, ip, networks)

		when 2 #when reading router
			interfaces = []
			name  = line[0]
			ports = line[1].to_i
			line.shift(2)
			ports.times do |x|
				mac, ip, mtu = line.shift 3
				interface    = Interface.new(name, mac, ip, mtu)
				interfaces.push(interface)
				add_to_network(interface, ip, networks)
			end
			router = Router.new
			router.interfaces = interfaces
			routers[name] = router

		when 3 #when reading routertable
			name, net_address, netx_hop, port = line
			route = RouterTableEntry.new(netx_hop, port)
			routers[name].router_table[net_address] = route

		end
	end
end

src = ARGV[1]
dst = ARGV[2]
msg = ARGV[3]

networks.each_value { |net| net.routers = routers }

nm = NetworkManager.new all_nodes, networks
nm.send_message(src, dst, msg)

