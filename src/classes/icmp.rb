class Icmp

	def self.request(from_name, from_ip, to_name, to_ip, message, ttl)
		puts '#{from_name} => #{to_name} : ICMP - Echo (ping) request (src=#{from_ip} dst=#{to_ip} ttl=#{ttl} data=#{message});'
	end

	def self.reply(from_name, from_ip, to_name, to_ip, message, ttl)
		puts '#{from_name} => #{to_name} : ICMP - Echo (ping) reply (src=#{from_IP} dst=#{to_IP} ttl=#{TTL} data=#{msg});'
	end

	def self.echo(from_name, message)
		puts '#{dst_name} rbox #{dst_name} : Received #{msg};'
	end
end
