File.open ARGV[0], "r" do |f|
	f.each_line do |line|
		if line[0] == "#"
			counter += 1
			next
		end
		line = line.split ','
		case counter
		when 1 #when reading node
		when 2 #when reading router
		when 3 #when reading routertable
		end
	end
end
