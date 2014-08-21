# Chess game client template

require 'socket'
require 'timeout'

ChessServer = '127.0.0.1'
ChessServerPort = 12321
ClientHost = '127.0.0.1'
PeerPort = 12322

WHITE, BLACK = 0, 1
Colors = %w[White Black]

def draw_board(board)
	puts <<-EOF
+--------------------------------+
|   Nothing here except chess    |
+--------------------------------+
	EOF
end

def analyze_move(my_color, move, turn, board)
	# Blacks always win on 4th turn
	if my_color == BLACK and turn == 4
		move << "  Checkmate!"
	end
	true	# Every move acceptable
end

def my_move(my_color, prev_move, num, board, socket)
	ok = false
	until ok do
		print "\nYour turn: "
		move = STDIN.gets.chomp
		ok = analyze_move(my_color, move, num, board)
		puts "Unacceptable move" if not ok
	end
	socket.puts move
	move
end

def other_move(who, move, num, board, sock)
	move = sock.gets.chomp
	puts "\nOpponent: #{move}"
	move
end

if ARGV[0]
	my_name = ARGV[0]
else
	print "Your name? "
	my_name = STDIN.gets.chomp
end

if ARGV[1]
	prefered_opponent_name_address = ARGV[1]
else
	print "Your opponent name@address? "
	prefered_opponent_name_address = STDIN.gets.chomp
end

#opponent_name = prefered_opponent_name_address.split("@")[0]

socket = TCPSocket.new(ChessServer, ChessServerPort)

response = nil

socket.puts %W[login #{my_name} #{prefered_opponent_name_address}].join(";;")
socket.flush
response = socket.gets.chomp
puts "LOG: Received \"#{response}\" from server"

opponent_name_address, my_color = response.split(";;")
opponent_name, opponent_address = opponent_name_address.split("@")
my_color = my_color.to_i

if my_color == WHITE
	puts "\nLOG: You are server..."
	server = TCPServer.new(ClientHost,PeerPort)
	puts "\nLOG: Waiting client connection..."
	session = server.accept
	puts "Session: #{session}"
	str = nil
	begin
		timeout(30) do
			str = session.gets.chomp
			if str != "ready"
				raise "ERROR: Received wrong ready message: #{str}"
			end
		end
	rescue TimeoutError
		raise "ERROR: No ready message from opponent for 30 seconds"
	end

	puts "Your opponent is \"#{opponent_name}\"... whites are yours"

	#who = WHITE
	prev_move = nil
	board = nil
	num = 0
	draw_board(board)
	loop do
		num += 1
		prev_move = my_move(my_color, prev_move, num, board, session)
		draw_board(board)
		case prev_move
		when "resign"
			puts "\nYou resigned. #{opponent_name} won!"
			break
		when /Checkmate/
			puts "\nYou checkmated #{opponent_name}!"
			draw_board(board)
			break
		end
		prev_move = other_move(my_color, prev_move, num, board, session)
		draw_board(board)
		case prev_move
		when "resign"
			puts "\n#{opponent_name} resigned. You won!"
			break
		when /Checkmate/
			puts "\n#{opponent_name} mated you!"
			break
		end
	end
# if color is not WHITE
else
	puts "\nConnecting to server #{opponent_address}:#{PeerPort}..."
	client = TCPSocket.new(opponent_address, PeerPort)
	client.puts "ready"

	puts "Your opponent is \"#{opponent_name}\"... blacks are yours"

	who = BLACK
	prev_move = nil
	board = nil
	num = 0
	draw_board(board)

	loop do
		num += 1
		prev_move = other_move(my_color, prev_move, num, board, client)
		draw_board(board)

		case prev_move
		when "resign"
			puts "\n#{opponent_name} resigned. You won!"
			break
		when /Checkmate/
			puts "\n#{opponent_name} mated you!"
			break
		end

		prev_move = my_move(my_color, prev_move, num, board, client)
		draw_board(board)

 		case prev_move
		when "resign"
			puts "\nYou resigned. #{opponent} won!"
			break
		when /Checkmate/
			puts "\nYou checkmated #{opponent}!"
			draw_board(board)
			break
		end
	end
	client.close
end