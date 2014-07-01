require 'csv'

names = ['John','Mark','Sally','Fred','Irene','Jake','Joanne']
CSV.open('./p311/my.csv','w') do |wr|
	wr << ['name','age','salary']
	names.size.times do
		wr << [names.shift,18+rand(30),(25+rand(20))*1000]
	end
end

CSV.open('./p311/my.csv','r') { |row| p row }