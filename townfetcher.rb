#!env ruby

require 'rubygems'
require 'mechanize'
require 'open-uri'

class Town

	attr_accessor	:name, :lat, :lon
	
	def init(name,lat,lon)
		@name = name
		@lat = lat
		@lon = lon
	end

end

def fetch_towns_of_catalonia
  a = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari' # Wikipedia blocks if not
  }
  
  base_url = 'http://ca.wikipedia.org'
    
  a.get('http://ca.wikipedia.org/wiki/Llista_de_municipis_de_Catalunya') do |page|
    table = page.search("//table[@class='wikitable sortable']").first;
    table.search('tr').each do |row|
      cell = row.search('td').first
      if (!cell.nil?) then
        node = cell.search('a').first
        url = base_url + node['href']
        puts url
      end
    end
  end
end

fetch_towns_of_catalonia
