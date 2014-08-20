require 'socket'

PORT = 12321

server = TCPServer.new(PORT)

while (session = server.accept)
	puts "Recieved packet"
	session.puts Time.new
	session.close
end