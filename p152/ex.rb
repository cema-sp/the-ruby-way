require 'i18n'

I18n::Backend::Simple.include(I18n::Backend::Pluralization)

class Person
		
	def initialize name,age,children_num
		@name, @age, @children_num = name, age, children_num
	end
	
	def show
		#puts _("Information")
		puts I18n.t 'Information'
		#puts _("Name: %{name}, Age: %{age}") % {name: @name, age: @age}
		puts I18n.t 'name_age', name: @name, age: @age
		#puts n_("%{name} has a child.", "%{name} has %{num} children.", @children_num) % {name: @name, num: @children_num}
		puts I18n.t 'children', count: @children_num, name: @name
	end
end

I18n.enforce_available_locales = true

#I18n.load_path = ['i18n/en.yml','i18n/ru.yml']
I18n.load_path = Dir.glob "i18n/**"

I18n.locale = :en
puts "Current locale: #{I18n.locale}"
john = Person.new("John", 25, 1)
john.show

I18n.locale = :ru
puts "Current locale: #{I18n.locale}"
linda = Person.new("Linda", 30, 22)
linda.show