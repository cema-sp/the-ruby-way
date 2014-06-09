require 'date'

class Calendar
	def initialize(year, month, mon=true)
		days = month_days(month, year)
		t = Time.mktime(year, month, 1)
		first = mon ? (t.wday+6)%7 : t.wday		#from Monday or Sunday?
		list = *(1..days)
		weeks = [[]]
		
=begin
		week1 = 7 - first
		week1.times {weeks[0] << list.shift }
		nweeks = list.size/7 + 1
		nweeks.times do |i|
			weeks[i+1] ||= []
			7.times do
				break if list.empty?
				weeks[i+1] << list.shift
			end
		end
		pad_first = 7-weeks[0].size
		pad_first.times {week[0].unshift(nil)}
		pad_last = 7-weeks[0].size
		pad_last.times {weeks[-1].unshift(nil)}
=end
		first.times {weeks[0] << nil}
		i = 0
		j = 0
		loop do
			weeks[i] ||= []
			if weeks[i].size >= 7
				i+=1
			else
				weeks[i] << list[j]
				j+=1
			end
			break if j>list.size
		end
		@weeks = weeks
	end
	
	def show
		@weeks.each do |wk|
			wk.each do |d|
				item = d.nil? ? " "*4 : " %2d " % d
				print item
			end
			puts
		end
		puts
	end
	
	def month_days(month, year=Date.today.year)
		mdays = [nil, 31, 28, 31, 30, 31, 30, 31, 31 ,30, 31, 30, 31]
		mdays[2] = 29 if Date.leap?(year)
		mdays[month]
	end
end

print "Insert ' '-delimited year, month, Monday[Y/N]: "
year_s, month_s, mon_s = gets.chomp.split(' ')
c = Calendar.new(year_s.to_i, month_s.to_i, mon_s=~/n/i ? false : true)
c.show