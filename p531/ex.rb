# class for testing

class MyClass
	attr_reader :var
	def initialize(par=nil)
		@var = par||'hello'
	end
	def goodbye
		@var = 'goodbye'
	end
end