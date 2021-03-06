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

		text_output2 = @builder.get_object 'resultOutput2'
		@result_value2 = text_output2.text

		text_output3 = @builder.get_object 'resultOutput3'
		@result_value3 = text_output3.text

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
		text_output2 = @builder.get_object 'resultOutput2'
		text_output3 = @builder.get_object 'resultOutput3'

		

		value = text_entry.text
		

		result = @converter.convert value
		result2 = @converter.normalize value
		result3 = @converter.treelizer value

		text_output.set_text ''

		text_output.set_text @result_value + result
		text_output2.set_text @result_value2 + "Resolviendo problemas, por favor regresa mas tarde ;)"
		text_output3.set_text @result_value3 + result3
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

	def selection_changed
		file_chooser = @builder.get_object 'filechooserbutton1'
		textview1 = @builder.get_object 'textview1'
		result = ""

		filename = file_chooser.preview_filename

		File.open(filename, "r") do |f|
  			f.each_line do |line|
    			nodes = line.scan(/<(.*?)>/).transpose;
    			pre_trans = line.scan(/(>.*?<)/).transpose;
    			for x in 0..nodes[0].length
    				unless pre_trans[0][x].nil?
	    				trans = pre_trans[0][x].scan(/([^;<>]+)/).transpose;
	    				node_elements = nodes[0][x].split(",")
	    				result = result + node_elements[0] + "\n"
	    				trans[0].each do |t|
	    					result = result + "\t" + t + "\n"
	    				end
    				end
    			end
    			textview1.buffer.text = result
  			end
		end
	end
end

view = View.new
view.startWindow()