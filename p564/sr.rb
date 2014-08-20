require 'socket'

PORT = 12321

server = TCPServer.new(PORT)

m_thr = Thread.new do
	while (session = server.accept)
		Thread.new(session) do |my_session|
			puts "Recieved packet"
			session.puts Time.new
			session.close
		end
	end
end

inp = ""
while (inp!='q')
	inp = gets.chomp
end
m_thr.kill