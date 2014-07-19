# encoding: utf-8

require 'fox16'

include Fox

class NonModalDialogBox < FXDialogBox
	def initialize(owner)
		super(owner, "Non Modal", DECOR_TITLE | DECOR_BORDER)
		
		text_options = JUSTIFY_RIGHT | FRAME_SUNKEN | 
						FRAME_THICK | LAYOUT_SIDE_TOP
		layout_options = LAYOUT_SIDE_TOP | FRAME_NONE | 
							LAYOUT_FILL_X | LAYOUT_FILL_Y |
							PACK_UNIFORM_WIDTH
		options = FRAME_RAISED | FRAME_THICK |
					LAYOUT_RIGHT | LAYOUT_CENTER_Y
					
		@text_field = FXTextField.new(self, 20, nil, 0, text_options)
		@text_field.text = ""
		
		FXHorizontalFrame.new(self, layout_options) do |layout|
			FXButton.new(layout, "&Спрятать", nil, nil, 0, options) do |btn|
				btn.connect(SEL_COMMAND) {hide}
			end
		end
	end
	def text
		@text_field.text
	end
end

class ModalDialodBox < FXDialogBox
	def initialize(owner)
		super(owner, "Modal", DECOR_TITLE | DECOR_BORDER)
		
		text_options = JUSTIFY_RIGHT | FRAME_SUNKEN | 
						FRAME_THICK | LAYOUT_SIDE_TOP
		layout_options = LAYOUT_SIDE_TOP | FRAME_NONE | 
							LAYOUT_FILL_X | LAYOUT_FILL_Y |
							PACK_UNIFORM_WIDTH
		options = FRAME_RAISED | FRAME_THICK |
					LAYOUT_RIGHT | LAYOUT_CENTER_Y
		
		@text_field = FXTextField.new(self, 20, nil, 0, text_options)
		@text_field.text = ""
		
		FXHorizontalFrame.new(self, layout_options) do |layout|
			FXButton.new(layout, "&Отменить", nil, self, 0, options) do |btn|
				btn.connect(SEL_COMMAND) do
					app.stopModal(self, 0)
					hide
				end
			end
			FXButton.new(layout, "&Принять", nil, self, 0, options) do |btn|
				btn.connect(SEL_COMMAND) do
					app.stopModal(self, 1)
					hide
				end
			end
		end
	end
	def text
		@text_field.text
	end
end

class DialogTestWindow < FXMainWindow
	def initialize(app)
		super(app, "Dialogs", nil, nil, DECOR_ALL, 0, 0, 400, 200)
		layout_options = LAYOUT_SIDE_TOP | FRAME_NONE | 
							LAYOUT_FILL_X | LAYOUT_FILL_Y |
							PACK_UNIFORM_WIDTH
		button_options = FRAME_RAISED | FRAME_THICK |
							LAYOUT_CENTER_X | LAYOUT_CENTER_Y
					
		FXHorizontalFrame.new(self, layout_options) do |layout|
			FXButton.new(layout, "&Немодальный диалог", nil, nil, 0, button_options) do |btn|
				btn.connect(SEL_COMMAND) {@non_modal_dialog.show(PLACEMENT_OWNER)}
			end
			FXButton.new(layout, "&Модальный диалог", nil, nil, 0, button_options) do |btn|
				btn.connect(SEL_COMMAND) do 
					dialog = ModalDialodBox.new(self)
					if dialog.execute(PLACEMENT_OWNER) == 1
						puts dialog.text
					end
				end
			end
		end
		
		getApp.addTimeout(1000, method(:onTimer))
		@non_modal_dialog = NonModalDialogBox.new(self)
	end
	
	def onTimer(sender, sel, ptr)
		text = @non_modal_dialog.text
		unless text == @previous
			@previous = text
			puts @previous
		end
		getApp.addTimeout(1000, method(:onTimer))
	end
	
	def create
		super
		show(PLACEMENT_SCREEN)
	end
end

app = FXApp.new
main = DialogTestWindow.new(app)
app.create
app.run