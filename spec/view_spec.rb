require "spec_helper"
require "./view"

describe View do
	it "has to be a window" do
		view = View.new
		isWindow = view.startWindow()
		isWindow.should be == true
	end
	it "has to have a input for the operation to convert"
	it "has to have a button that trigger the convertion action of the input"
	it "has to have a button that trigger the file read and convertion of elements in the file"
end