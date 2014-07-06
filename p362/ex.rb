class IL1
	@@home_planet = nil
	
	def IL1.home_planet
		@@home_planet
	end
	def IL1.home_planet=(x)
		@@home_planet = x
	end
	def IL1.show
		puts @@home_planet
	end
end

class T1 < IL1
	@@home_planet = "Earth"
end
class M1 < IL1
	@@home_planet = "Mars"
end

IL1.show
T1.show
M1.show
# prints Mars three times (class variable 
# is same for all parent and subclasses)
#--------------------------------------

class IL2
	def IL2.home_planet
		class_eval("@@home_planet")
	end
	def IL2.home_planet=(x)
		class_eval("@@home_planet = #{x}")
	end
	def IL2.show
		class_eval("puts @@home_planet")
	end
end
class T2 < IL2
	@@home_planet = "Earth"
end
class M2 < IL2
	@@home_planet = "Mars"
end

# IL2.show throws an error
T2.show
M2.show
# prints proper values, because parent class 
# has no variable
#---------------------------------------

class IL3
	class << self
		attr_accessor :home_planet
	end
	def IL3.show
		puts self.home_planet
	end
end

class T3 < IL3
	self.home_planet = "Earth"
end

class M3 < IL3
	self.home_planet = "Mars"
end

IL3.show
T3.show
M3.show
# prints proper values, because using singlet variables