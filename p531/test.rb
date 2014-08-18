require 'test/unit'
require_relative 'ex.rb'

class MyTestClass < Test::Unit::TestCase
	def setup
		@mc = MyClass.new
	end
	def test_001
		assert_equal("hello", @mc.var, "Initialization failure")
	end
	def test_002
		@mc.goodbye
		assert_equal("goodbye", @mc.var)
	end
	def test_003
		mc = MyClass.new('test')
		assert_equal("test", mc.var)
	end
end