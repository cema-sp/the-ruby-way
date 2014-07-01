class Person
	attr_reader :name, :age, :balance

	def initialize(name,birthdate,initial_balance)
		@name, @birthdate, @initial_balance = 
			name, birthdate, initial_balance
		@age = (Time.now - @birthdate)/(365*86400)
		@balance = @initial_balance*(1.05**@age)
	end

	def marshal_dump
		Struct.new("Human",:name,:birthdate,:initial_balance)
		str = Struct::Human.new(@name, @birthdate, @initial_balance)
	end

	def marshal_load(str)
		self.instance_eval do
			initialize(str.name,str.birthdate,str.initial_balance)			
		end
	end
end

p1 = Person.new("Oleg", Time.now - (14*365*86400), 100)

p [p1.name, p1.age, p1.balance]

str = Marshal.dump(p1)

p str
puts str.class

p2 = Marshal.load(str)

p [p2.name, p2.age, p2.balance]