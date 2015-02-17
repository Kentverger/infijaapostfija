require "spec_helper"
require "converter"

describe Converter do
	it "convert a+b to ab+"
	it "convert a*b to ab*"
	it "convert a/b to ab/"
	it "convert a-b to ab-"
	it "read a file called input.csv and convert form infix to postfix"
	it "write on a the same file called input.csv the result of the convertions"
end