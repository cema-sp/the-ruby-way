# encoding: utf-8
require 'tk'

# pack parameters:
Top = {'side'=>'top', 'padx'=>5,'pady'=>5}
Left = {'side'=>'left', 'padx'=>5,'pady'=>5}
Bottom = {'side'=>'bottom', 'padx'=>5,'pady'=>5}

temp = 22	# initial temperature

root = TkRoot.new {title "Термостат"}

top = TkFrame.new(root) {background "#606060"}
bottom = TkFrame.new(root)

# temperature color
def temp_color(temp_)
	case temp_
		when -100..0 
			"blue"
		when 1..15 
			"green"
		when 16..25 
			"yellow"
		else 
			"red"
	end
end

# temperature
tlab = TkLabel.new(top) do
	text temp.to_s
	font "{Arial} 54 {bold}"
	foreground temp_color(temp)
	background "#606060"
	pack Left
end

# degree symbol
tlab_d = TkLabel.new(top) do
	text "o"
	font "{Arial} 14 {bold}"
	foreground temp_color(temp)
	background "#606060"
	pack Left.update({'anchor'=>'n'})
end

# up button
TkButton.new(bottom) do
	text " Поднять "
	command proc {
		tlab.configure("text" => (temp+=1).to_s, 
						"foreground" => temp_color(temp))
		tlab_d.configure("foreground" => temp_color(temp))
	}
	pack Left
end

# down button
TkButton.new(bottom) do
	text " Опустить "
	command proc {
		tlab.configure("text" => (temp-=1).to_s, 
						"foreground" => temp_color(temp))
		tlab_d.configure("foreground" => temp_color(temp))
	}
	pack Left
end

top.pack Top
bottom.pack Bottom

Tk.mainloop

