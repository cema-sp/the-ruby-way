require 'simplecov'

SimpleCov.start

# Code Generated by ZenTest v. 4.10.1
#                 classname: asrt / meth =  ratio%
#                   MyClass:    0 /    2 =   0.00%

require 'test/unit/testcase'
require 'test/unit' if $0 == __FILE__

require "#{File.expand_path(File.dirname(__FILE__))}/../lib/my_gem/myclass.rb"

class TestMyClass < Test::Unit::TestCase
	def setup
		@m = MyClass.new('test')
	end
	def test_show
		assert_equal(['t','e','s','t'],@m.show)
	end
end

# Number of errors detected: 2
