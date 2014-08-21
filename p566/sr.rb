# Chess game server template

require 'thread'
require 'socket'

PORT = 12321
HOST = '127.0.0.1'

waiter = Thread.new do
	puts "+--------------------------------+"
	puts "|  Press \"Enter\" to stop server  |"
	puts "+--------------------------------+"
	gets
	exit
end

$mutex = Mutex.new
$list = {}

def match?(player1, player2)
	return false if !$list[player1] or !$list[player2]

	if ($list[player1][0] == player2 and 
		$list[player2][0] == player1)
		puts "LOG: #{player1} matches #{player2}"
		true
	else
		puts "LOG: #{player1} doesn't match #{player2}"
		false
	end
end

def handle_client(session, command, player1_address, port, ipname)
	$mutex.synchronize do
		command_name, player1_name, player2_name_address = command.split(";;")
		player2_name, player2_address = player2_name_address.split("@")

		player1_name_address = player1_name + "@" + player1_address
		player2_name_address = player2_name + "@" +IPSocket.getaddress(player2_address)

		if command_name != "login"
			puts "ERROR: Received \"#{command}\""
		end

		$list[player1_name_address] = [player2_name_address, port, session]

		if match?(player1_name_address, player2_name_address)
			p1 = $list[player1_name_address]
			p2 = $list[player2_name_address]
			# color: 0=white, 1=black
			sess1 = p1[2]
			sess2 = p2[2]
			sess1.puts "#{player2_name_address};;1"
			sess2.puts "#{player1_name_address};;0"
			sess1.close
			sess2.close
		end

	end
end

text = nil

$server = TCPServer.new(HOST,PORT)
while session = $server.accept do
	Thread.new(session) do |sess|
		command = sess.gets.chomp
		puts "LOG: Recieved command \"#{command}\" from #{sess.peeraddr}"
		domain, port, ipname, ipaddr = sess.peeraddr
		handle_client(sess, command, ipaddr, port, ipname)
		sleep 1
	end
end

waiter.join