require 'delegate'
require 'forwardable'

class MyQueue1 < DelegateClass(Array)
	def initialize(arg=[])
		super(arg)
	end
	
	alias_method :enqueue, :push
	alias_method :dequeue, :shift
end

class MyQueue2
	extend Forwardable
	def initialize(obj=[])
		@queue=obj
	end
	
	def_delegator :@queue, :push, :enqueue
	def_delegator :@queue, :shift, :dequeue
	def_delegators :@queue, :clear, :empty?, :length, :size, :<<
end

#---------------------------------------------

q = MyQueue1.new
q.enqueue(123)
q.enqueue(456)

p q.dequeue
p q.dequeue

q = MyQueue2.new
q.enqueue(123)
q.enqueue(456)

p q.dequeue
p q.dequeue