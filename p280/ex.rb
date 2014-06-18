require 'graphviz'

puts "Insert connected nodes (' '-dilimited, 'quit' - quit): "
puts "ex: one two three"

g = GraphViz.new(:G, type: :digraph)
g.node[:style] = "filled"
g.node[:color] = "purple"

loop do
	inp = gets.chomp
	break if inp=='quit'
	nodes = inp.split(' ')
	# take first node
	first = nodes.shift
	# add first node in not exists
	g.add_node(first) unless g.find_node(first) 
	nodes.each do |node|
		g.add_node(node) unless g.find_node(node)
		g.add_edge(first,node)
	end
end

g.output(png:"graph.png")
