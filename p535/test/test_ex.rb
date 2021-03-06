require 'simplecov'
SimpleCov.start


# Code Generated by ZenTest v. 4.10.1
#                 classname: asrt / meth =  ratio%
#                     Alpha:    0 /    5 =   0.00%
#               Alpha::Beta:    0 /    2 =   0.00%

require 'test/unit/testcase'
require 'test/unit' if $0 == __FILE__

require "#{File.expand_path(File.dirname(__FILE__))}/../lib/ex.rb"

class TestAlpha < Test::Unit::TestCase
  def setup
    @alpha = Alpha.new
  end
  def test_process
    assert_equal('orange',@alpha.process)
  end

  def test_process_bang
    assert_equal('orange'.split($;),@alpha.process!)
  end
  def test_new_meth
    assert_equal('new', @alpha.new_meth)
  end
  def test_double_equals
    assert_equal(true,@alpha=='orange')
  end
  def test_triple_equals
    assert_equal(true,@alpha==='orange')
  end
end

class TestAlpha::TestBeta < Test::Unit::TestCase
  def setup
    @beta = Alpha::Beta.new('carrot')
  end
  def test_bar
    assert_equal('carrot',@beta.bar)
  end

  def test_bar_equals
    @beta.bar= 'grapefruit'
    assert_equal('grapefruit',@beta.bar)
  end

  def test_foo
    assert_equal(true,@beta.foo)
  end

  def test_foo_eh
    assert_equal(false,@beta.foo?)
  end

  def test_foo_equals
    @beta.foo= false
    assert_equal(false,@beta.foo)
  end
end

# Number of errors detected: 9
