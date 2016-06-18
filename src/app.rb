
require_relative 'modules/ip'

Dir['classes/*.rb'].each do |file|
	require_relative file
end

counter    = 0
networks   = {}
routers    = {}

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
			include Ip
			net_address = dec_to_addr(addr_to_dec(ip) & network_mask(ip))
			if networks[net_address].nil?
				net = Network.new net_address
				net.interfaces.push node
				networks[net_address] = net
			else
				networks[net_address].interfaces.push node
			end

		when 2 #when reading router
			interfaces = []
			name  = line[0]
			ports = line[1].to_i
			line.shift(2)
			ports.times do |x|
				mac, ip, mtu = line.shift 3
				interface    = Interface.new(name, mac, ip, mtu)
				interfaces.push(interface)
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

