# encoding: utf-8
require 'net/http'
require 'json'
require 'graphviz'

# process node (vk id, dpth_limit, wdth_limit, curr_dpth, curr_width)
def process_node(graph, id, parent_id, dpth_limit, wdth_limit, curr_dpth=0)

	#user_request = '/method/users.get?user_id='+id
	#user_response = Net::HTTP.get_response('api.vk.com',user_request)
	user_response = '{"response":[{"uid":823999,"first_name":"Иван","last_name":"Иванов","hidden":1}]}'
	user_response_hash = JSON.parse(user_response)
	
	# if no error
	if user_response_hash.include? 'response'
		# make full name of person
		full_name = user_response_hash['response'][0]['last_name']+" "+
			user_response_hash['response'][0]['first_name']
		
		puts "#{full_name} d=#{curr_dpth}"
		#p graph.display
		#puts "adding node #{id}"
		graph.add_node(id, label: full_name)
		#puts "added node #{id}"
		#puts "adding edge #{parent_id}-#{id}"
		graph.add_edge(parent_id,id) unless parent_id.nil?
		#puts "added edge #{parent_id}-#{id}"
		
		# if depth reached and id processed
		return 1 if curr_dpth>=dpth_limit
		
		# find person's friends
		#friends_request = '/method/friends.get?user_id='+id
		#friends_response = Net::HTTP.get_response('api.vk.com',friends_request)
		friends_response = '{"response":[147553,270489,329011,658308,1623970,1761631,1910805,1961797,2011376,2066894]}'
		
		friends_response_hash = JSON.parse(friends_response)
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

g = GraphViz.new(:G, type: :digraph)
process_node(g, init_id, nil, 1, 2)
g.output(png:"graph.png")

#test = JSON.parse('{"one":"two"}')
#p test