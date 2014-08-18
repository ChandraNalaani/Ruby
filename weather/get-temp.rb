#!/usr/bin/env ruby

# load our gem
## require 'httparty'
require 'barometer'

# we think there are some args in an array called ARGV
if ARGV.size == 0
  puts "Usage: get-temp.rb PLACE_NAME"
  exit 0
end

# make request
## response = HTTParty.get("http://api.wunderground.com/api/f2e41b273cfd6a41/conditions/q/#{ARGV[0]}.json")
barometer = Barometer.new(ARGV[0])
weather = barometer.measure

location = weather.measurements[0].location
if location.state_code
  location_string = "#{location.city}, #{location.state_code}"
else
  location_string = "#{location.city}, #{location.country}"
end

# parse and display response
## puts response['current_observation']['temperature_string']
puts "It's #{weather.current.temperature} in #{location.string} right now"
