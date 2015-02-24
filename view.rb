require 'gtk3'

class View
	def initialize
		super

		builder = Gtk::Builder.new
		builder.add_from_file('GUI.glade')

	end

	def startWindow
		Gtk.init
		Gtk.main

		return true
	end
end

view = View.new
view.startWindow()