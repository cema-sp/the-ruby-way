# coerce example

class MyNumberClass
	attr_reader :val
	def initialize(i)
		@val = i
	end
	def to_s
		@val
	end
	def to_i
		@val.to_i
	end
	def to_f
		@val.to_f
	end
	def +(other)
		if other.kind_of?(MyNumberClass)
			MyNumberClass.new(@val+other.val)
		else
			n1, n2 = coerce(other)
			n1 + n2
		end
	end
	def coerce(other)
		if other.kind_of? Float
			return other, self.to_i
		elsif other.kind_of? Integer
			return other, self.to_f
		else
			super
		end
	end
end

#-----------------------------------
a = MyNumberClass.new(5)
b = MyNumberClass.new(7)
puts (a+b).to_s
puts (a+3).to_s
