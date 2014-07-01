reader, writer = IO.pipe

str = nil
thr1 = Thread.new(reader,writer) do |reader, writer|
	str = reader.gets
	reader.close
end

thr2 = Thread.new(reader,writer) do |reader, writer|
	writer.puts("Hello there!")
	writer.close
end

thr1.join
thr2.join

puts str