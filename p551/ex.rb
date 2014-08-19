# simple file for RDoc

require 'foo'

# This
# is
# my
# class

class MyClass
	CONST = 237

	# Nested class MyClass::Alpha
	# = Heading 1
	# == Heading 2
	# === Heading 3
	# ---
	# List:
	# - one
	# - two
	# - three

	class Alpha

		#Nested class MyClass::Alpha::Beta
		#Block comment with
		#some *bold*,_italic_ and +code+
		class Beta
			# Метод класса Alpha::Beta mymeth1
			=begin
			Hidden comment
			=end
			def mymeth1

			end
		end

		# Метод класса Alpha mymeth2
		def mymeth2

		end
	end

	# MyClass initialization

	def initialize(a,b,c)

	end

	# Default object creation (calss method)
	def self.create; end

	# just instance method

	def do_something
	end
end