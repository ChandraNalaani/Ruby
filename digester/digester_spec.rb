require_relative "./digester"

describe Digester, "#digest" do
	it "returns a string" do
		digester = Digester.new
		digester.digest("Some input").should be_a(String)
	end

	it "returns a different string for a different input" do
		digester = Digester.new
		result = digester.digest("Some input")
		other_result = digester.digest("Some other input")
		result.should_not eq(other_result)
	end

	it "returns the same string for the same input called again" do
		digester = Digester.new
		result = digester.digest("Some input")
		other_result = digester.digest("Some input")
		result.should eq(other_result)
	end

	it "returns a uniformly different output for two different inputs" do
		digester = Digester.new

		input_a = "Some input"
		result_a = digester.digest(input_a)

		input_b = "some input"
		result_b = digester.digest(input_b)

		different_chars = 0
		result_a.length.times.each do |i|
			different_chars += 1 if result_a[i] != result_b[i]
		end
		different_chars.should >= result_a.length / 2
	end

end
