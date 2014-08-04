# encoding: UTF-8

require 'Qt'
require 'unicode'

class MyWidget < Qt::Widget
	slots 'buttonClickedSlot()'
	def initialize(parent = nil)
		super(parent)
		
		setWindowTitle("Пример QtRuby")
		@lineedit = Qt::LineEdit.new(self)
		@button = Qt::PushButton.new("КАПС", self)
		
		connect(@button, SIGNAL('clicked()'),
				self, SLOT('buttonClickedSlot()'))
				
		box = Qt::HBoxLayout.new
		box.addWidget(Qt::Label.new("Текст:"))
		box.addWidget(@lineedit)
		box.addWidget(@button)
		
		setLayout(box)
	end
	
	def buttonClickedSlot
		lineedit_utf_8 = @lineedit.text.force_encoding('UTF-8')
		@lineedit.setText(Unicode::upcase(lineedit_utf_8))
	end
end

app = Qt::Application.new(ARGV)
widget = MyWidget.new
widget.show
app.exec