require 'bigdecimal'

puts (3.2 - 2.0) == 1.2 ? "yes" : "no"

x = BigDecimal("3.2")
y = BigDecimal("2.0")
z = BigDecimal("1.2")

puts (x - y) == z ? "yes" : "no"