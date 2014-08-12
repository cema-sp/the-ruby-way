
def compose(*objects)
	threads = []
	for obj in objects do
		threads << Thread.new(obj) do |myobj|
			me = Thread.current
			me[:queue] = []
			myobj.each {|x| me[:queue].push(x)}
			p me[:queue]
		end
	end

	list = [0]
	while list.count{|x| !x.nil?} > 0 do
		list = []
		for thr in threads
			(list << thr[:queue].shift) if thr.key?(:queue)
		end
		yield list if list.count{|x| !x.nil?} > 0
	end
end

x = [1,2,3,4,5]
y = %w[one two three]
z = %w[a b c]

compose(x,y,z) {|i,j,k| p [i,j,k]}