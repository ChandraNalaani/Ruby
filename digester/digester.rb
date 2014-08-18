class Digester
	def digest(input)
		result = 0
		input.each_char do |character|
			# transform result in proportion to ascii code for char
			result = (result * 33) + character.getbyte(0)
		end
		result.to_s
	end
end