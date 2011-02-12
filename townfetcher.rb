#!env ruby

require 'rubygems'
require 'mechanize'

class Town

	attr_accessor	:name, :lat, :lon
	
	def init(name,lat,lon)
		@name = name
		@lat = lat
		@lon = lon
	end

end