# Chess game client template

require 'socket'
require 'timeout'

ChessServer = '127.0.0.1'
ChessServerPort = 12321
PeerPort = 12001

WHITE, BLACK = 0, 1
Colors = %w[White Black]

def draw_board(board)
	puts <<-EOF
+--------------------------------+
|   Nothing here except chess    |
+--------------------------------+
	EOF
end

def analyze_move(who, move, num, board)
	# Blacks always win on 4th turn
	if who == BLACK and num == 4
		move << "  MATE"
	end
	true	# Every move acceptable
end

def my_move(who, lastmove, num, board, sock)
	ok = false
	until ok do
		print "\nYour turn: "
		move = STDIN.gets.chomp
		ok = analyze_move(who, move, num, board)
		puts "Unacceptable move" if not ok
	end
	sock.puts move
	move
end

def other_move(who, move, num, board, sock)
	move = sock.gets.chomp
	puts "\nOpponent: #{move}"
	move
end

if ARGV[0]
	myself = ARGV[0]
else
	print "Your name? "
	myself = STDIN.gets.chomp
end

if ARGV[1]
	opponent_id = ARGV[1]
else
	print "Your opponent? "
	opponent_id = STDIN.gets.chomp
end

opponent = opponent_id.split(":")[0]

socket = TCPSocket.new(ChessServer, ChessServerPort)

response = nil

socket.puts "login #{myself} #{opponent_id}"
socket.flush
response = socket.gets.chomp

name, ipname, color = response.split(":")
color = color.to_i

if color == BLACK
	puts "\nConnecting to peer..."

	server = TCPServer.new(PeerPort)
	session = server.accept

	str = nil
	begin
		timeout(30) do
			str = session.gets.chomp
			if str != "ready"
				raise "Error: received ready message: #{str}"
			end
		end
	rescue TimeoutError
		raise "Error: no ready message from opponent"
	end

	puts "Your opponent is \"#{opponent}\"... whites are yours"

	who = WHITE
	move = nil
	board = nil
	num = 0
	draw_board(board)
	loop do
		num += 1
		move = my_move(who, move, num, board, session)
		draw_board(board)
		case move
		when "resign"
			puts "\nYou resigned. #{opponent} won!"
			break
		when /Checkmate/
			puts "\nYou mated #{opponent}!"
			draw_board(board)
			break
		end
		move = other_move(who, move, num, board, session)
		draw_board(board)
		case move
		when "resign"
			puts "\n#{opponent} resigned. You won!"
			break
		when /Checkmate/
			puts "\n#{opponent} mated you!"
			break
		end
	end
# if color is not BLACK
else
	puts "\nConnecting to peer..."
	socket = TCPSocket.new(ipname, PeerPort)
	socket.puts "ready"

	puts "Your opponent is \"#{opponent}\"... blacks are yours"

	who = BLACK
	move = nil
	board = nil
	num = 0
	draw_board(board)

	loop do
		num += 1
		move = other_move(who, move, num, board, socket)
		draw_board(board)

		case move
		when "resign"
			puts "\n#{opponent} resigned. You won!"
			break
		when /Checkmate/
			puts "\n#{opponent} mated you!"
			break
		end

		 move = my_move(who, move, num, board, socket)
		 draw_board(board)

 		case move
		when "resign"
			puts "\nYou resigned. #{opponent} won!"
			break
		when /Checkmate/
			puts "\nYou mated #{opponent}!"
			draw_board(board)
			break
		end
	end
	socket.close
end