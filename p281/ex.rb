# encoding: utf-8

require 'net/http'
require 'json'
require 'graphviz'

module LblStringPatch
	def output
		'"'+eval(super)+'"'
	end
end
class GraphViz::Types::LblString
	prepend LblStringPatch
		
	alias :to_gv :output
	alias :to_s :output
	alias :to_ruby :output
end

def process_node(graph, id, parent_id, dpth_limit, wdth_limit, curr_dpth=0)

	user_request = '/method/users.get?user_id='+id
	user_response = Net::HTTP.get_response('api.vk.com',user_request)
	#user_response = '{"response":[{"uid":823999,"first_name":"Иван","last_name":"Иванов","hidden":1}]}'
	user_response_hash = JSON.parse(user_response.body)
	
	# if no error
	if user_response_hash.include? 'response'
		# make full name of person
		full_name = user_response_hash['response'][0]['last_name']+" "+
			user_response_hash['response'][0]['first_name']
		
		puts "#{full_name} d=#{curr_dpth}"
		n = graph.add_node(id, :label => full_name)
		graph.add_edge(parent_id,id) unless parent_id.nil?
		
		# if depth reached and id processed
		return 1 if curr_dpth>=dpth_limit
		
		# find person's friends
		friends_request = '/method/friends.get?user_id='+id
		friends_response = Net::HTTP.get_response('api.vk.com',friends_request)
		#friends_response = '{"response":[147553,270489,329011,658308,1623970,1761631,1910805,1961797,2011376,2066894]}'
		
		friends_response_hash = JSON.parse(friends_response.body)
		# if no error
		if friends_response_hash.include? 'response'
			
			puts "parsing friends of #{full_name} d=#{curr_dpth}"
			friends_array = friends_response_hash['response']
			#puts friends_array
			friends_array.inject(0) do |succ, friend_id| 
				# break if width limit reached
				break if succ >= wdth_limit
				
				puts "processing friend #{friend_id} of #{full_name} d=#{curr_dpth}"
				
				succ+process_node(graph, friend_id.to_s, id, dpth_limit, wdth_limit, curr_dpth+1)
			end
		end
		# if id received and fully processed
		return 1
	else
		# if no id received
		return 0
	end
end

print "Insert VK ID: "
init_id = gets.chomp
print "Insert Tree Depth: "
dpth_limit = gets.chomp.to_i
print "Insert Subtrees Width: "
wdth_limit = gets.chomp.to_i


g = GraphViz.new(:G, type: :digraph, charset: "utf8")
process_node(g, init_id, nil, dpth_limit, wdth_limit)
g.output(png:"graph.png")