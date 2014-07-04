require 'kirbybase'

db = KirbyBase.new(:local, nil, nil,
						"#{File.expand_path(File.dirname(__FILE__))}/kb")

people = db.create_table(:people,
							:name, :String,
							:age, :Integer,
							:salary, :Integer)

names = %w[John Igor Sandra Sebastian Pit Rust Kathy]

names.size.times do
	people.insert(name: names.shift, age: (18+rand(10)), salary: (25+rand(30))*1000)
end

all_people = people.select
puts all_people.to_report

young_people = people.select {|x| x.age < 25 }
puts young_people.sort(-:age).to_report