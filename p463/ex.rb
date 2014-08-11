
buffer = SizedQueue.new(2)

producer = Thread.new do
	item = 0
	loop do
		sleep rand 0
		puts "Producer produced #{item}"
		buffer.enq item
		item += 1
	end
end

consumer = Thread.new do
	loop do
		sleep (rand 0)+0.9
		item = buffer.deq
		puts "Consumer consumed #{item}"
		puts "Waiting: #{buffer.num_waiting}"
	end
end

sleep 20