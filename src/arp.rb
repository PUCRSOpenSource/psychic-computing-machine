class Arp

	def self.request(from_name, from_ip, to_ip)
		puts '#{from_name} box #{from_name} : ARP - Who has #{to_ip}? Tell #{from_ip};'
	end

	def self.reply(from_name, from_ip, from_mac, to_name)
		puts '#{from_name} => #{to_name} : ARP - #{from_ip} is at #{from_mac};'
	end

end
