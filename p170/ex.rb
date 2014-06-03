#example: http://www.rusnauka.com/33_DWS_2010/33_DWS_2010/Matemathics/74680.doc.htm

require 'matrix'

#	Rows (resources): juice, workforce, water
#	Columns (economy fields): industry, agriculture
rsc_fld = Matrix[[5.3,4.1],
				[2.8,2.1],
				[4.8,5.1]]

#	Company produce: P1, P2, P3
#	Company uses: S1, S2

#	Rows: products
#	Columns: resources
a = Matrix[[2,3],
			[5,2],
			[1,4]]

#	Production plan
c = Matrix[[100,80,130]]

#	Resources cost
b = Matrix[[30],[50]]

puts "Resources usage (C*A) = #{c*a}"
puts "Overall cost (C*A*B) = #{c*a*b}"