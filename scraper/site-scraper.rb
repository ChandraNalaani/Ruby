require 'nokogiri'
require 'open-uri'

def open_page(url)
  Nokogiri::HTML(open(url))
end

# get a count of 'obama' vs 'romney' keywords
def extract_keywords(elements)
  elements.each do |node|
    link = node.attr('href')
    page = open_page(link)
    story_paragraphs = page.css('.story-wrapper div.story-text p')

    puts "#{page.title}: #{keywords_from_list(story_paragraphs)}"
  end
end

def keywords_from_list(list)
  result = {}

  list.each do |item|
    ARGV.each do |keyword|
      if item.inner_text.match(/#{keyword}/i)
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

doc = open_page('http://www.politico.com')
titles = doc.css('#mainContent li h3 a[href*="http"]')
extract_keywords(titles)