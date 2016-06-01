
Dir['classes/*.rb'].each do |file|
	require_relative file
end

counter = 0

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
			puts line.to_s
			interface = Interface.new(line[1], line[2], line[3])
			node = Node.new(line[0], line[4], interface)
		when 2 #when reading router
			puts line.to_s
		when 3 #when reading routertable
			puts line.to_s
		end

	end

end


