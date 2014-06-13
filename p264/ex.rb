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
	# lst in array is first in stack
	def peek
		@store.last
	end
	def empty?
		@store.empty?
	end
end

class Queue
	def initialize
		@store=[]
	end
	def push(v)
		@store.unshift(v)
	end
	def pop
		@store.pop
	end
	# lst in array is first in stack
	def peek
		@store.last
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

str1 = '((a-b)*2)+5*[c/d]'
str2 = '((a-b)*2+5*[c/d]'

puts "String: #{str1}"
puts paren_mach(str1) ? "Correct" : "Incorrect"
puts "String: #{str2}"
puts paren_mach(str2) ? "Correct" : "Incorrect"

