require 'gtk3'
require "./converter"

class View
	def startWindow
		@builder = Gtk::Builder.new
		@builder.add_from_file 'GUI.glade'

		@converter = Converter.new

		window = @builder.get_object 'applicationwindow1'

		@builder.connect_signals { |name| method(name) }
		
		text_output = @builder.get_object 'resultOutput'
		@result_value = text_output.text

		window.show
		window.set_title 'Convierte de infija a postfija'

		Gtk.main

		return true
	end

	def convert
		text_entry = @builder.get_object 'inputInfix'
		text_output = @builder.get_object 'resultOutput'

		value = text_entry.text
		

		result = @converter.convert value

		text_output.set_text ''

		text_output.set_text @result_value + result
	end

	def convert_file
		
	end
end

view = View.new
view.startWindow()