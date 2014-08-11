
@music = Mutex.new
@violin = ConditionVariable.new
@bow = ConditionVariable.new

@violins_free = 2
@bows_free = 1

def musician(n)
	loop do
		sleep rand 0
		@music.synchronize do
			@violin.wait(@music) while @violins_free == 0
			@violins_free -= 1
			puts "#{n} owns a violin"
			puts "Violins free: #{@violins_free}, bows free: #{@bows_free}"

			@bow.wait(@music) while @bows_free == 0
			@bows_free -= 1
			puts "#{n} owns a bow"
			puts "Violins free: #{@violins_free}, bows free: #{@bows_free}"
		end

		sleep rand 0
		puts "#{n} plays music..."
		sleep rand 0
		puts "#{n} finished playing"

		@music.synchronize do
			@violins_free += 1
			@violin.signal if @violins_free >= 1
			@bows_free += 1
			@bow.signal if @bows_free >= 1
		end
	end
end

threads = []
3.times {|i| threads << Thread.new {musician(i+1)}}

threads.each {|t| t.join 30}