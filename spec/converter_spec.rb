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
	it "convert a|b to ab|" do
		converter = Converter.new
		result = converter.convert("a|b")
		result.should be == "ab|"
	end
	it "convert a?b to ab?" do
		converter = Converter.new
		result = converter.convert("a?b")
		result.should be == "ab?"
	end
	it "convert a*b|c to ab*c|" do
		converter = Converter.new
		result = converter.convert("a*b|c")
		result.should be == "ab*c|"
	end
	it "convert 2*b|c.d to 2b*cd.|" do
		converter = Converter.new
		result = converter.convert("2*b|c.d")
		result.should be == "2b*cd.|"
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

	it "chec the importance of * vs +" do
		converter = Converter.new
		importance = converter.important2('*', '+')
		importance.should  == -1
	end
	it "chec the importance of * vs ?" do
		converter = Converter.new
		importance = converter.important2('*', '?')
		importance.should  == -1
	end
	it "chec the importance of * vs *" do
		converter = Converter.new
		importance = converter.important2('*', '*')
		importance.should  == -1
	end
	it "chec the importance of * vs ." do
		converter = Converter.new
		importance = converter.important2('*', '.')
		importance.should  == true
	end
	it "chec the importance of * vs |" do
		converter = Converter.new
		importance = converter.important2('*', '|')
		importance.should  == true
	end

	it "chec the importance of + vs +" do
		converter = Converter.new
		importance = converter.important2('+', '+')
		importance.should  == -1
	end
	it "chec the importance of + vs ?" do
		converter = Converter.new
		importance = converter.important2('+', '?')
		importance.should  == -1
	end
	it "chec the importance of + vs *" do
		converter = Converter.new
		importance = converter.important2('+', '*')
		importance.should  == -1
	end
	it "chec the importance of + vs ." do
		converter = Converter.new
		importance = converter.important2('+', '.')
		importance.should  == true
	end
	it "chec the importance of + vs |" do
		converter = Converter.new
		importance = converter.important2('+', '|')
		importance.should  == true
	end

	it "chec the importance of ? vs +" do
		converter = Converter.new
		importance = converter.important2('?', '+')
		importance.should  == -1
	end
	it "chec the importance of ? vs ?" do
		converter = Converter.new
		importance = converter.important2('?', '?')
		importance.should  == -1
	end
	it "chec the importance of ? vs *" do
		converter = Converter.new
		importance = converter.important2('?', '*')
		importance.should  == -1
	end
	it "chec the importance of ? vs ." do
		converter = Converter.new
		importance = converter.important2('?', '.')
		importance.should  == true
	end
	it "chec the importance of ? vs |" do
		converter = Converter.new
		importance = converter.important2('?', '|')
		importance.should  == true
	end

	it "chec the importance of . vs +" do
		converter = Converter.new
		importance = converter.important2('.', '+')
		importance.should  == false
	end
	it "chec the importance of . vs ?" do
		converter = Converter.new
		importance = converter.important2('.', '?')
		importance.should  == false
	end
	it "chec the importance of . vs *" do
		converter = Converter.new
		importance = converter.important2('.', '*')
		importance.should  == false
	end
	it "chec the importance of . vs ." do
		converter = Converter.new
		importance = converter.important2('.', '.')
		importance.should  == -1
	end
	it "chec the importance of . vs |" do
		converter = Converter.new
		importance = converter.important2('.', '|')
		importance.should  == true
	end

	it "chec the importance of | vs +" do
		converter = Converter.new
		importance = converter.important2('|', '+')
		importance.should  == false
	end
	it "chec the importance of | vs ?" do
		converter = Converter.new
		importance = converter.important2('|', '?')
		importance.should  == false
	end
	it "chec the importance of | vs *" do
		converter = Converter.new
		importance = converter.important2('|', '*')
		importance.should  == false
	end
	it "chec the importance of | vs ." do
		converter = Converter.new
		importance = converter.important2('|', '.')
		importance.should  == false
	end
	it "chec the importance of | vs |" do
		converter = Converter.new
		importance = converter.important2('|', '|')
		importance.should  == -1
	end


	it "write on a the same file called input.csv with the result of the convertions" do
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
	it "if the file has been used or tested it has to return -1" do
		converter = Converter.new
		converted = converter.readAndConvert("input.csv")
		converted.should == -1
	end
	it "if the file doesnt exist, should return false" do
		converter = Converter.new
		converted = converter.readAndConvert("lol.csv")
		converted.should == false
	end

	it "has to convert ab to a.b" do
		converter = Converter.new
		result = converter.normalize("ab")
		result.should be == "a.b"
	end
	it "has to convert a+b to a+.b" do
		converter = Converter.new
		result = converter.normalize("a+b")
		result.should be == "a+.b"
	end
	it "has to convert a*b to a*.b" do
		converter = Converter.new
		result = converter.normalize("a*b")
		result.should be == "a*.b"
	end
	it "has to convert a?b to a?.b" do
		converter = Converter.new
		result = converter.normalize("a?b")
		result.should be == "a?.b"
	end
	it "has to convert d+aa|c to d+.a.a|c" do
		converter = Converter.new
		result = converter.normalize("d+aa|c")
		result.should be == "d+.a.a|c"
		
	end
end