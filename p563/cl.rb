require 'socket'
require 'timeout'

PORT = 12321
HOST = 'localhost'

socket = UDPSocket.new
socket.connect(HOST, PORT)

socket.send("", 0)
timeout(10) do
	time = socket.gets
	puts time
end