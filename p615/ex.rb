require 'wee'
#require 'wee/utils'
#require 'wee/adaptors/webrick'

class Counter < Wee::Component
	attr_accessor :count

	def initialize(initial_count=0)
		super()
		@count = initial_count
		#add_decorator Wee::StyleDecoration.new(self)
	end
	#def state(s) super
	#	s.add_ivar(self, :@count)
	#end
	def dec
		@count -= 1
	end
	def inc
		@count += 1
	end
	def style
		".wee-counter a {border: 1px dotted blue; margin: 2px;}"
	end
	def render(r)
		r.div.oid.css_class('wee-counter').with do
			r.anchor.callback_method(:dec).with('--')
			r.space
			r.text @count.to_s
			r.space
			r.anchor.callback_method(:inc).with('++')
		end
		
	end
end

Wee.run(Counter)