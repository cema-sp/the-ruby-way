require 'socket'

PORT = 12321
HOST = 'localhost'

session = TCPSocket.new(HOST, PORT)
time = session.gets
session.close
puts time