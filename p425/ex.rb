# encoding: utf-8

require 'fox16'

include Fox

class TwoButtonWindow < FXMainWindow
	def initialize(app)
		super(app, "Update Example", nil, nil, 
				DECOR_TITLE | DECOR_CLOSE)
		@button_one = FXButton.new(self, "¬кл. кнопку 2")
		@button_one_enabled = true
		
		@button_two = FXButton.new(self, "¬кл. кнопку 1")
		@button_two.disable
		@button_two_enabled = false
		
		@button_one.connect(SEL_COMMAND, method(:onCommand))
		@button_two.connect(SEL_COMMAND, method(:onCommand))
		@button_one.connect(SEL_UPDATE, method(:onUpdate))
		@button_two.connect(SEL_UPDATE, method(:onUpdate))
		
		@pwd = ""
		
		@tf = FXTextField.new(self, 20, nil, 0,
						JUSTIFY_RIGHT | 
						FRAME_SUNKEN | FRAME_THICK |
						LAYOUT_SIDE_TOP)
						
		@tf.connect(SEL_UPDATE, method(:update_tf))
	end
	
	def show_dialog
		@pwd = FXInputDialog.getString("123", self, "No Cyrillic", 
										"¬ведите пароль: ", nil)
	end
	
	def update_tf(sender, sel, ptr)
		@tf.text = @pwd
	end
	
	def onCommand(sender, sel, ptr)
		@button_one_enabled = !@button_one_enabled
		@button_two_enabled = !@button_two_enabled
	end
	
	def onUpdate(sender, sel, ptr)
		@button_one_enabled ? @button_one.enable : 
								@button_one.disable
								
		@button_two_enabled ? @button_two.enable : 
								@button_two.disable
	end
end

app = FXApp.new
main = TwoButtonWindow.new(app)
app.create
main.show(PLACEMENT_SCREEN)
main.show_dialog
app.run