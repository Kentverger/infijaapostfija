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
	it "has to convert a|b to a|b" do
		converter = Converter.new
		result = converter.normalize("a|b")
		result.should be == "a|b"
	end
	it "has to convert d+a|c to d+.a|c" do
		converter = Converter.new
		result = converter.normalize("d+a|c")
		result.should be == "d+.a|c"
		
	end

	it "has to check if * is binary operator" do
		converter = Converter.new
		importance = converter.binary('*')
		importance.should  == false
	end	
	it "has to check if + is binary operator" do
		converter = Converter.new
		importance = converter.binary('+')
		importance.should  == false
	end
	it "has to check if . is binary operator" do
		converter = Converter.new
		importance = converter.binary('.')
		importance.should  == true
	end
	it "has to check if | is binary operator" do
		converter = Converter.new
		importance = converter.binary('|')
		importance.should  == true
	end
	it "has to check if ? is binary operator" do
		converter = Converter.new
		importance = converter.binary('?')
		importance.should  == false
	end


	it "has to convert a.b to .ab" do
		converter = Converter.new
		result = converter.treelizer("a.b")
		result.should be == ".ab"
	end

	it "has to convert a|b to |ab" do
		converter = Converter.new
		result = converter.treelizer("a|b")
		result.should be == "|ab"
	end

	it "has to convert a+ to +a" do
		converter = Converter.new
		result = converter.treelizer("a+")
		result.should be == "+a"
	end

	it "has to convert a* to *a" do
		converter = Converter.new
		result = converter.treelizer("a*")
		result.should be == "*a"
	end

	it "has to convert a? to ?a" do
		converter = Converter.new
		result = converter.treelizer("a?")
		result.should be == "?a"
	end
	it "has to convert a|b*.c to |a.*bc" do
		converter = Converter.new
		result = converter.treelizer("a|b*.c")
		result.should be == "|a.*bc"
	end	
	it "has to convert a+.b* to .+a*b" do
		converter = Converter.new
		result = converter.treelizer("a+.b*")
		result.should be == ".+a*b"
	end

	it "has to convert a.b|a+.c? to |.ab.+a?c" do
		converter = Converter.new
		result = converter.treelizer("a.b|a+.c?")
		result.should be == "|.ab.+a?c"
	end
	it "has to convert b?.c to .?bc" do
		converter = Converter.new
		result = converter.treelizer("b?.c")
		result.should be == ".?bc"
	end
	it "has to convert c+.a to .+ca" do
		converter = Converter.new
		result = converter.treelizer("c+.a")
		result.should be == ".+ca"
	end
	it "has to convert b?.c|c+.a to |.?bc.+ca" do
		converter = Converter.new
		result = converter.treelizer("b?.c|c+.a")
		result.should be == "|.?bc.+ca"
	end

end