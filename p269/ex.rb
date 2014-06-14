# Tree class
class Tree
	attr_accessor :left, :right, :data

	def initialize(x=nil)
		@left, @right = nil
		@data = x
	end
	# just insert, no sort
=begin
	def insert(x)
		list=[]
		if @data == nil
			@data = x
		elsif @left == nil
			@left = Tree.new(x)
		elsif @right == nil
			@right = Tree.new(x)
		else
			list << @left
			list << @right
			loop do
				node = list.shift
				if node.left == nil
					node.insert(x)
					break
				else
					list << node.left
				end
				if node.right == nil
					node.insert(x)
					break
				else
					list << node.right
				end
			end
		end
	end
=end
	#insert for further sort
	def insert(x)
		if @data == nil
			@data = x
		elsif x <= @data
			if @left == nil
				@left = Tree.new(x)
			else
				@left.insert(x)
			end
		else
			if @right == nil
				@right = Tree.new(x)
			else
				@right.insert(x)
			end
		end	
	end
	#going top-down left-right
	def traverse
		list = []
		yield @data
		list << @left if @left != nil
		list << @right if @right != nil
		loop do
			break if list.empty?
			node = list.shift
			yield node.data
			list << node.left if node.left != nil
			list << node.right if node.right != nil
		end
	end
	#going left-right
	def inorder
		@left.inorder {|y| yield y} if @left != nil
		yield @data
		@right.inorder {|y| yield y} if @right != nil
	end
	#going top-down left-right
	def preorder
		yield @data
		@left.inorder {|y| yield y} if @left != nil
		@right.inorder {|y| yield y} if @right != nil
	end
	#going down-top left-right
	def postorder
		@left.inorder {|y| yield y} if @left != nil
		@right.inorder {|y| yield y} if @right != nil
		yield @data
	end

	def search(x)
		if self.data == x
			return self
		elsif x<self.data
			return left ? left.search(x) : nil
		elsif x>self.data
			return right ? right.search(x) : nil
		end
	end

	def to_s
		'('+
		if left then left.to_s + ', ' else '' end +
		data.to_s +
		if right then ', ' + right.to_s else '' end +
		')'
	end

	def to_a
		temp = []
		temp += left.to_a if left
		temp << data
		temp += right.to_a if right
		temp
	end
end


print "Insert ' '-delimited array: "
arr = gets.chomp.split(' ')
tree = Tree.new
arr.each {|a| tree.insert(a)}

print "Values for search: "
search_values = gets.chomp.split(' ')
search_values.each {|v| puts "For #{v}: #{tree.search(v)}"}

puts "Traverse: "
tree.traverse {|v| print "#{v} "}
print "\n"
puts "Inorder: "
tree.inorder {|v| print "#{v} "}
print "\n"
puts "Preorder: "
tree.preorder {|v| print "#{v} "}
print "\n"
puts "Postorder: "
tree.postorder {|v| print "#{v} "}
print "\n"

puts "Tree to string: #{tree}"
puts "Tree to aray: #{tree.to_a}"
