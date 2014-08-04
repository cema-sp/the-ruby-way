# encoding: UTF-8

require 'Qt'

class MyTextWindow < Qt::Widget
	slots 'theTextChanged()'
	
	def initialize(parent = nil)
		super(parent)
		
		@textedit = Qt::TextEdit.new(self)
		@textedit.setWordWrapMode(Qt::TextOption::WordWrap)
		@textedit.setFont(Qt::Font.new("Times", 24))
		
		@status = Qt::Label.new(self)
		
		box = Qt::VBoxLayout.new
		box.addWidget(@textedit)
		box.addWidget(@status)
		
		setLayout(box)
		
		@textedit.insertPlainText("Это текстовый редактор")
		
		connect(@textedit, SIGNAL('textChanged()'),
				self, SLOT('theTextChanged()'))
	end
	
	def theTextChanged
		text = "Символов: "+@textedit.toPlainText.length.to_s
		@status.setText(text)
	end
end

app = Qt::Application.new(ARGV)
widget = MyTextWindow.new
widget.setWindowTitle("Текстовый редактор")
widget.show
app.exec