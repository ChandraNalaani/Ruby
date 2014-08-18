require 'foursquare2'
require 'pry'
require 'pry-nav'
require 'colorize'
client = Foursquare2::Client.new(:client_id => '---', :client_secret => '---')
#API CALLS -------------------------------
venues_data = client.search_venues(:ll => '37.762414, -122.419108', :query => 'gym')
venues = venues_data.groups[0].items
# this is sorting by _stats.checkinsCount
venue_details = []
venues.each do |v|
  the_venue = client.venue(v.id)
  venue_details << the_venue
  #Adding all tips to our venues
  v.the_tips = the_venue.tips.groups[0].items
end
#------------------------------------------------------------
#MAGIC SEARCH ENGINE ----------------------------------------
the_request = 'pool'
results = []
venues.each do |v|
  v.the_tips.each do |tip|
    if tip.text.match(the_request)
      the_result = Hashie::Mash.new
      the_result.venue = v
      the_result.tip = tip
      results << the_result
    end
  end
end
# RESULTS OUTPUT -------------------------------------------
# SORT THE RESULTS
results.sort! do |b, a|
  a.venue.stats.checkinsCount <=> b.venue.stats.checkinsCount
end
# ----------------------------------------------------------
results.each do |r|
  puts "#{r.venue.name} #{r.venue.stats.checkinsCount}".blue
  # highlights the matched query
  matches = r.tip.text.match(/(.*)#{the_request}(.*)/)
  print matches[1].green
  print "#{the_request}".yellow
  puts matches[2].green
end
#------------------------------------------------------------
binding.pry