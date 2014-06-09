class Transition 
	A,B = :A,:B
	T,F = true,false
	
	Table = {[A,F,F]=>[A,F], [B,F,F]=>[B,T],
				[A,T,F]=>[B,F], [B,T,F]=>[B,T],
				[A,F,T]=>[A,F], [B,F,T]=>[A,F],
				[A,T,T]=>[A,T], [B,T,T]=>[A,T]}
	def initialize(proc1, proc2)
		@state = A
		@proc1, @proc2 = proc1, proc2
		#check?
	end
	def check?(line)
		p1 = @proc1.call(line) ? T : F
		p2 = @proc2.call(line) ? T : F
		@state, result = *Table[[@state, p1, p2]]
		result
	end
end

text = <<EOF
line 1 text
st_start
1 statement
st_end
line 2 text
st_start
1 statement
2 statement
long text of statement
3 statement
st_end
line 3 text
EOF

puts "Only statements: ",''
tr = Transition.new(proc {|line| line=~/st_start/}, proc{|line| line=~/st_end/})
text.each_line {|line| puts line if tr.check?(line)}
