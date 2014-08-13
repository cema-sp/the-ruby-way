require 'Win32API'

# 8  bytes string
result = "0"*8

getCursorXY = Win32API.new("user32","GetCursorPos",["P"],"V")
getCursorXY.call(result)

# two long numbers
x,y = result.unpack("LL")

puts [x,y]