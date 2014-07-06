# block initialization

class PersonalComputer
	attr_writer :manuf, :model, :processor, :ram, :disk, :monitor
	def initialize(&block)
		instance_eval &block
	end
	def to_s
		puts "Manufacturer: #{@manuf}" if @manuf
		puts "Model: #{@model}" if @model
		puts "Processor: #{@processor}" if @processor
		puts "RAM: #{@ram}" if @ram
		puts "Disk: #{@disk}" if @disk
		puts "Monitor: #{@monitor}" if @monitor
	end
end

#-----------------------------------------------------------

my_pc = PersonalComputer.new do
	self.manuf = "Dell"
	self.processor = "Core i5"
	self.disk = "2 Tb"
	self.monitor = "LG Flatron"
end

puts my_pc