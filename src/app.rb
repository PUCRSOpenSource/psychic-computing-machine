
Dir['classes/*.rb'].each do |file|
	require_relative file
end

counter = 0
nodes   = Array.new
routers = Array.new

File.open ARGV[0], "r" do |f|

	f.each_line do |line|
		if line[0] == "#"
			counter += 1
			next
		end

		line = line.split ','
		line.map! { |x| x.chomp }

		case counter
		when 1 #when reading node
			interface = Interface.new(line[1], line[2], line[3])
			node      = Node.new(line[0], line[4], interface)
			nodes    << node
		when 2 #when reading router
			interfaces = Array.new
			name  = line[0]
			ports = line[1].to_i
			line  = line.shift 2
			ports.times do |x|
				mac, ip, mtu = line.shift 3
				interface    = Interface.new(mac, ip, mtu)
				interfaces  << interface
			end
			router   = Router.new(name, ports, interfaces)
			routers << router
		when 3 #when reading routertable
			puts line.to_s
		end

	end

end

