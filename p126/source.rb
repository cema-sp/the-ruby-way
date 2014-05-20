text = <<-EOF
<body><h1>H1 title here</h1>
<p>Long paragraph with <italic>italic</italic>
and some <bold>bold</bold> text</p>
</body>
EOF

pattern = /(?:^|	#line beginning
			(?<=>)	#text after '>'
			)
			([^<]*)	#everything except '<'
			/x
			
puts text.gsub(pattern) {|s| s.upcase}