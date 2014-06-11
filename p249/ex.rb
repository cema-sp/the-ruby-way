# hash with duplicates

class HashDup
	def initialize(*all)
		raise IndexError if all.size % 2 != 0
		@store = {}
		if all[0]	#first element is not nill
			keyval = all.dup
			while !keyval.empty?
				key = keyval.shift
				if @store.has_key?(key)
					@store[key] += [keyval.shift]
				else
					@store[key] = [keyval.shift]
				end
			end
		end
	end
	def store(k,v)
		if @store.has_key?(k)
			@store[k] += [v]
		else
			@store[k] = [v]
		end
	end
	def [](key)
		@store[key]
	end
	def []=(key,value)
		self.store(key,value)
	end
	def to_s
		@store.to_s
	end
	def to_a
		@store.to_a
	end
	def inspect
		@store.inspect
	end
	def keys
		result=[]
		@store.each do |k,v|
			result += ([k]*v.size)
		end
		result
	end
	def values
		@store.values.flatten
	end
	def each
		@store.each {|k,v| v.each {|y| yield k,y}}
	end
	alias each_pair each
	def each_key
		self.keys.each {|k| yield k}
	end
	def each_value
		self.values.each {|v| yield v}
	end
	def has_key? k
		self.keys.include? k
	end
	def has_value? v
		self.values.include? v
	end
	def length
		self.values.size
	end
	alias size length
	def delete k
		val = @store[k]
		@store.delete(k)
		val
	end
	def delete(k,v)
		@store[k] -= [v] if @store[k]
	end
	#invert
	def invert
		result = {}
		@store.each do |k,v|
			v.each {|val| result[val]=k}
		end
		result
	end
end

h = {"a"=>1,"b"=>2,"c"=>3,"b"=>4}
hd = HashDup.new("a",1,"b",2,"c",3,"b",4)

print "Hash: "
p h
print "HashDup: "
p hd
puts "HashDup Keys: #{hd.keys}"
puts "HashDup Values: #{hd.values}"
puts "HashDup Invert: #{hd.invert}"
