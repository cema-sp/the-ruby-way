
@list = []
@list[0] = "shoes ships\nsealing-wax"
@list[1] = "cabbage kings"
@list[2] = "quarks\nships\ncabbage"

def hesitate
	sleep rand(0)
end

# shared resource
@hash = {}

@mutex = Mutex.new

def process_list(listnum)
	lnum = 0
	@list[listnum].split("\n").each do |line|
		words = line.chomp.split(" ")
		words.each do |w|
			hesitate
			# lock mutex
			@mutex.lock
				if @hash[w]
					hesitate
					@hash[w] += ["#{listnum}:#{lnum}"]
				else
					hesitate
					@hash[w] = ["#{listnum}:#{lnum}"]
				end
			# unlock mutex
			@mutex.unlock
		end
		lnum += 1
	end
end

t1 = Thread.new(0) {|num| process_list(num)}
t2 = Thread.new(1) {|num| process_list(num)}
t3 = Thread.new(2) {|num| process_list(num)}

t1.join
t2.join
t3.join

count = 0
@hash.values.each {|v| count += v.size}

puts "Words count: #{count}"
