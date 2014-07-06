# using append_features

module MyMod
	def MyMod.append_features(someClass)
		def someClass.modmeth
			puts "Class method from module"
		end
		super		# should be here
	end
	def meth1
		puts "Object method from module"
	end
end

class MyClass
	include MyMod
	
	def MyClass.classmeth
		puts "Class method from class"
	end
	
	def meth2
		puts "Object method from class"
	end
end

#--------------------------------------------------

x = MyClass.new

MyClass.classmeth
MyClass.modmeth
x.meth2
x.meth1