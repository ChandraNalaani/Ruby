require 'nokogiri'
require 'open-uri'

# get a count of 'obama' vs 'romney' keywords
def extract_keywords(elements, keywords)
  result = {}
  
  elements.each do |node|
    keywords.each do |keyword|
      if node =~ /#{keyword}/i # node.downcase.include?(keyword.downcase)
        if result[keyword]
          result[keyword] += 1
        else
          result[keyword] = 1
        end
      end
    end
  end

  result
end

doc = Nokogiri::HTML(open('http://www.politico.com'))
titles = doc.css('#mainContent li h3')
# keywords = ['obama', 'romney']
keywords = ARGV
# p ARGV
puts extract_keywords(titles, keywords)