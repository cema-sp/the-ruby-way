# encoding: utf-8

require 'fox16'

include Fox

c_dir = File.expand_path(File.dirname(__FILE__))

application = FXApp.new
main = FXMainWindow.new(application, "No Cyrillic")
main.decorations = DECOR_TITLE | DECOR_CLOSE
str = Time.now.strftime("&Сегодня\n%B %d %Y")
icon = File.open("#{c_dir}/c.gif", "rb") do |file|
	FXGIFIcon.new(application, file.read)
end
button = FXButton.new(main,str, icon)
button.connect(SEL_COMMAND) {application.exit}
application.create
main.show(PLACEMENT_SCREEN)
application.run