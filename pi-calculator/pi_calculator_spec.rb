$:<< "."
require 'pi_calculator'

describe PiCalculator, "#calculate" do
  it "returns something really damn close to pi" do
    pi_calculator = PiCalculator.new
    pi = pi_calculator.calculate
    pi.should be_within(0.01).of(3.14)
  end
end
