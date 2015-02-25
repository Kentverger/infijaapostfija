#!/usr/bin/env ruby

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

		text_file_output = @builder.get_object 'resultSuccess'
		@result_file_value = text_file_output.text

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

		text_file_output = @builder.get_object 'resultSuccess'

		text_file_output.set_text ''

		converter = Converter.new
		converted = converter.readAndConvert("input.csv")

		if converted == -1
			text_file_output.set_text @result_file_value + "El archivo ya ha sido testeado"
		elsif converted == false
			text_file_output.set_text @result_file_value + "El archivo no existe"
		else
			text_file_output.set_text @result_file_value + "El archivo testeado"
		end
	end

	def on_window_destroy
		Gtk.main_quit
	end
end

view = View.new
view.startWindow()