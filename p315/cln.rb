require 'kirbybase'

host = 'localhost'
port = 44444

db = KirbyBase.new(:client, host, port)

people = db.get_table(:people)

young_people = people.select {|x| x.age < 25 }
puts young_people.sort(-:age).to_report
