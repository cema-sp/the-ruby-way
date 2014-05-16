class String
	def margin
		arr = self.split("\n")
		arr.map!{|x| x.sub!(/\s*\|/,"")}
		str = arr.join("\n")
		self.replace(str)
	end
end

s = []
s << "Tab symbol: (\t)"
s << "Three backspaces: 123\b\b\b"
s << "Tab symbol again: (\011)"
s << "Sound beep symbol: (\a \007)"
s << %q[Just text with %q: " ' \ | /]
s << %Q_Same text with %Q: " ' \ | /_
s << <<'EOF'
Multi-line 
text
...
EOF
s << <<EOF.margin
  |Hello there
  |	<-wow! TAB
  |\t<-one more
EOF

s.each do |str|
	puts str
end