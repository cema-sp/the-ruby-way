# Stack and Queue
# Stack is LIFO
class Stack
	def initialize
		@store = []
	end
	def push(v)
		@store.push(v)
	end
	def pop
		@store.pop
	end
	# last in array is first in stack
	def peek
		@store.last
	end
	def empty?
		@store.empty?
	end
end
# Queue is FIFO
class Queue
	def initialize
		@store=[]
	end
	def enqueue(v)
		@store  << v
	end
	def dequeue
		@store.shift
	end
	# first in array is first in queue
	def peek
		@store.first
	end
	def empty?
		@store.empty?
	end
end

def paren_mach(str)
	stack = Stack.new
	lsym = '{[(<'
	rsym = '}])>'
	str.each_byte do |byte|
		sym = byte.chr
		if lsym.include?(sym)
			stack.push(sym)
		elsif rsym.include?(sym)
			top = stack.peek
			if lsym.index(top) != rsym.index(sym)
				return false
			else
				stack.pop
			end
		end
	end
	return stack.empty?
end

def towers(list)
	states = {}
	n, src, dst, aux = list.last
	states[src] = n
	states[dst] = 0
	states[aux] = 0
	while !list.empty?
		n, src, dst, aux = list.pop
		if n == 1
			states[src] -= 1
			states[dst] += 1
			print "#{src} -> #{dst} "
			states.each {|k,v| print "#{k}:#{v} "}
			puts ''
		else
			list.push([n-1, aux, dst, src])
			list.push([1, src, dst, aux])
			list.push([n-1, src, aux, dst])
		end
	end
end

def towers_rec(states,list)
	n, src, dst, aux = *list
	states ||= states
	states[src] ||= n
	states[dst] ||= 0
	states[aux] ||= 0
	if n == 1
		states[src] -= 1
		states[dst] += 1
		print "#{src} -> #{dst} "
		states.each {|k,v| print "#{k}:#{v} "}
		puts ''
	else
		towers_rec(states,[n-1, src, aux, dst])
		towers_rec(states,[1, src, dst, aux])
		towers_rec(states,[n-1, aux, dst, src])
	end
end

str1 = '((a-b)*2)+5*[c/d]'
str2 = '((a-b)*2+5*[c/d]'

puts "String: #{str1}"
puts paren_mach(str1) ? "Correct" : "Incorrect"
puts "String: #{str2}"
puts paren_mach(str2) ? "Correct" : "Incorrect"

list = [[3, "src", "dst", "aux"]]
puts "No recursion:"
towers(list)
list = [[3, "src", "dst", "aux"]]
puts "With recursion:"
towers_rec({},list.flatten)