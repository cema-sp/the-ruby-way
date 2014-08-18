class Alpha
	class Beta
		attr_accessor :foo, :bar

		def initialize(fruit='lemon')
			@foo, @bar = true, fruit
		end
		def foo?
			@foo
		end
	end

	def initialize
		@beta = Beta.new('orange')
	end

	def process
		@beta.bar
	end

	def process!
		@beta.bar.split($;)
	end

	def ==(other)
		@beta.bar==other.bar
	end

	def ===(other)
		@beta.bar===other.bar
	end
end