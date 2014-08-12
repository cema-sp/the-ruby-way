# Queue and Sized Queue realization

class Queue
	def initialize
		@que = []
		@monitor = Monitor.new
		@empty_cond = @monitor.new_cond
	end

	def enq(obj)
		@monitor.synchronize do
			@que.push(obj)
			@empty_cond.signal
		end 
	end

	def deq
		@monitor.synchronize do
			while @que.empty?
				@empty_cond.wait
			end
			return @que.shift
		end
	end
end

class SizedQueue < Queue
	attr :max

	def initialize(max)
		super()
		@max = max
		@full_cond = @monitor.new_cond
	end

	def enq(obj)
		@monitor.synchronize do
			while @que.length >= @max
				@full_cond.wait
			end
			super(obj)
		end
	end

	def deq
		@monitor.synchronize do
			obj = super
			if @que.length < @max
				@full_cond.signal
			end
			return obj
		end
	end

	def max=(max)
		@monitor.synchronize do
			@max = max
			@full_cond.broadcast
		end
	end
end

#-----------------------------------------------------

q = SizedQueue.new(4)
i = 0

thr1 = Thread.new do
	loop do
		sleep rand 0
		q.enq(i)
		puts "Enqueue: #{i}"
		i += 1
		sleep rand 0
	end
end

thr2 = Thread.new do
	loop do
		sleep (rand 0)+0.9
		puts "Dequeue: #{q.deq}"
		sleep (rand 0)+0.9
	end
end

thr1.join 30
thr2.join 30