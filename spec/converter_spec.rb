require "spec_helper"
require "./converter"

describe Converter do
	it "convert a+b to ab+" do
		converter = Converter.new
		result = converter.convert("a+b")
		result.should be == "ab+"
	end
	it "convert a*b to ab*" do
		converter = Converter.new
		result = converter.convert("a*b")
		result.should be == "ab*"
	end
	it "convert a/b to ab/" do
		converter = Converter.new
		result = converter.convert("a/b")
		result.should be == "ab/"
	end
	it "convert a-b to ab-" do
		converter = Converter.new
		result = converter.convert("a-b")
		result.should be == "ab-"
	end
	it "convert a-b+c to abc+-" do
		converter = Converter.new
		result = converter.convert("a-b+c")
		result.should be == "abc+-"
	end
	it "convert 2*b+c/d to 2b*cd/+" do
		converter = Converter.new
		result = converter.convert("2*b+c/d")
		result.should be == "2b*cd/+"
	end
	it "check the importance of + versus *" do
		converter = Converter.new
		importance = converter.important('+', '*')
		importance.should be = false
	end
	it "check the importance of - versus *" do
		converter = Converter.new
		importance = converter.important('-', '*')
		importance.should be = false
	end
	it "check the importance of * versus *" do
		converter = Converter.new
		importance = converter.important('*', '*')
		importance.should  == -1
	end
	it "check the importance of / versus *" do
		converter = Converter.new
		importance = converter.important('/', '*')
		importance.should  == -1
	end
	it "check the importance of + versus /" do
		converter = Converter.new
		importance = converter.important('+', '/')
		importance.should be = false
	end
	it "check the importance of - versus /" do
		converter = Converter.new
		importance = converter.important('-', '/')
		importance.should be = false
	end
	it "check the importance of * versus /" do
		converter = Converter.new
		importance = converter.important('*', '/')
		importance.should  == -1
	end
	it "check the importance of / versus /" do
		converter = Converter.new
		importance = converter.important('/', '/')
		importance.should  == -1
	end
	it "check the importance of + versus +" do
		converter = Converter.new
		importance = converter.important('+', '+')
		importance.should  == -1
	end
	it "check the importance of - versus +" do
		converter = Converter.new
		importance = converter.important('-', '+')
		importance.should  == -1
	end
	it "check the importance of * versus +" do
		converter = Converter.new
		importance = converter.important('*', '+')
		importance.should  == true
	end
	it "check the importance of / versus +" do
		converter = Converter.new
		importance = converter.important('/', '+')
		importance.should  == true
	end
	it "check the importance of + versus -" do
		converter = Converter.new
		importance = converter.important('+', '-')
		importance.should  == -1
	end
	it "check the importance of - versus -" do
		converter = Converter.new
		importance = converter.important('-', '-')
		importance.should  == -1
	end
	it "check the importance of * versus -" do
		converter = Converter.new
		importance = converter.important('*', '-')
		importance.should == true
	end
	it "check the importance of / versus -" do
		converter = Converter.new
		importance = converter.important('/', '-')
		importance.should == true
	end
	it "write on a the same file called input.csv with the result of the convertions"
		converter = Converter.new
		converted = converter.readAndConvert("input.csv")
		tmp = true
		CSV.foreach("input.csv") do |row|
			if row[2] == ''
				tmb = false
			end
		end
		tmp.should == true
	end
	it "if the file has been used or tested it has to return -2"
	it "if the file doesnt exist, should return -1"
	it "if the converter or write fails must return false" do
		converter = Converter.new
		converted = converter.readAndConvert("input.csv")
		converted.should == false
	end
end