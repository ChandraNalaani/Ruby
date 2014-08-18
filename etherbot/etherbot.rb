require 'etherpad-lite'
require 'piggy_latin'
require 'pry'
require 'pry-nav'

ether = EtherpadLite.connect('http://---.com', '---')

pad = ether.pad('noisebridge')
i = 0

pig = PigLatin::Translator.new(:dash => false)

while true
  text = pad.text
  puts i
  i += 1

  # i suggest simply looking for keywords

  # for example -- look for the keyword ALLCAPS, then find the string
  # that follows ALLCAPS and make it caps and remove
  # the keyword ALLCAPS

  # even simpler example -
  if result = text.match(/PIGLATIN (.+)\n/)
    word = result[1]

    new_text = text.gsub(word, pig.translate(word))
    new_text.gsub!(/PIGLATIN/, "")

    # sets the text to new text
    pad.text = new_text
  end

  sleep 2.0
end