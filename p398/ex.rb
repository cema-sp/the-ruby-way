require 'tk'

root = TkRoot.new( 'title' => 'Date App')
str = Time.now.strftime("Today is \n%B %d, %Y")
lbl = TkLabel.new(root) do
	text str
	pack("padx"=> 15, "pady"=> 10, "side"=> "top")
end
btn_OK = TkButton.new (root) do
	text "OK"
	command (proc {puts "OK button pressed"})
	pack("padx"=> 15, "pady"=> 20, "side"=>"left")
end
Tk.mainloop