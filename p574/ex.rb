require 'net/http'
require 'thread'

class TrueRandom
	def initialize(min=nil,max=nil,buff=nil,slack=nil)
		@buffer = []
		@site = 'www.random.org'
		# if first class instance
		if !defined? @init_flag
			@min = min || 0
			@max = max || 1
			@buffsize = buff || 1000
			@slacksize = slack || 300
			@mutex = Mutex.new
			@thread = Thread.new {fillbuffer}
			@init_flag = true
		# if not first class instance
		else
			@min = min || @min
			@max = max || @max
			@buffsize = buff || @buffsize
			@slacksize = slack || @slacksize
		end 
		@path = '/integers/?col=1&base=10&format=plain&rnd=new&'+
			"num=#{@buffsize}&min=#{@min}&max=#{@max}"
	end
	def fillbuffer
		response = Net::HTTP.get_response(@site, @path)
		@buffer += response.body.split($/)
	end

	def rand
		num = nil
		@mutex.synchronize {num = @buffer.shift}
		if @buffer.size < @slacksize
			if !@thread.alive?
				@thread = Thread.new {fillbuffer}
			end
		end
		if num == nil
			if @thread.alive?
				@thread.join
			else
				@thread = Thread.new {fillbuffer}
				@thread.join
			end
			@mutex.synchronize {num = @buffer.shift}
		end
		num.to_i
	end
end

#-------------------------------------------------------

t = TrueRandom.new(1,6,1000,300)

count = {}
6.times{|i| count[i+1] = 0}

10000.times do |n|
	x = t.rand
	count[x] += 1
end

p count