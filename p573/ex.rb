# Dices emulation with usage of http://www.random.org
require 'net/http'

HOST = 'www.random.org'
RAND_URL = '/integers/?col=1&base=10&format=plain&rnd=new&'

def get_random_numbers(count=1, min=0, max=99)
	path = RAND_URL + "num=#{count}&min=#{min}&max=#{max}"
	response = Net::HTTP.get_response(HOST,path)
	if response.code == '200'
		response.body.split($/).map(&:to_i)
	else
		[]
	end
end
DICE_LINES = [
"+-----++-----++-----++-----++-----++-----+",
"|     ||  *  || *   || * * || * * || * * |",
"|  *  ||     ||  *  ||     ||  *  || * * |",
"|     ||  *  ||   * || * * || * * || * * |",
"+-----++-----++-----++-----++-----++-----+"
]

DIE_WIDTH = DICE_LINES[0].size/6

def draw_dice(values)
	DICE_LINES.each do |line|
		for v in values
			print line[(v-1)*DIE_WIDTH, DIE_WIDTH]
			print " "
		end
		puts
	end
end

#---------------------------------------------

draw_dice(get_random_numbers(6,1,6))

