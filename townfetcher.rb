#!env ruby

require 'rubygems'
require 'mechanize'
require 'uri'
require 'open-uri'
require 'json'

class Town

	attr_accessor	:name, :lat, :lon
	
	def initialize(name,lat,lon)
		@name = name
		@lat = lat
		@lon = lon
	end
	
	def to_s
	  "#{@name} Lat:#{@lat} -- Lon:#{@lon}"
  end

end

def fetch_towns_of_catalonia
  towns = Array.new
  
  a = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari' # Wikipedia blocks if not
  }
  
  base_url = 'http://ca.wikipedia.org'
  
  api_url = "http://api.idescat.cat/pob/v1/cerca.json?p=q/"
  options = ";sim/0,1;tipus/mun"
    
  a.get('http://ca.wikipedia.org/wiki/Llista_de_municipis_de_Catalunya') do |page|
    table = page.search("//table[@class='wikitable sortable']").first;
    table.search('tr').each do |row|
      cell = row.search('td').first
      if (!cell.nil?) then
        node = cell.search('a').first
        
        url = base_url + node['href']
        
        puts 
        name = node['title']
        towns.insert(-1,name)
        
        query = api_url + name + options
        query = URI.escape(query)
        puts "#{name} => #{query}"
        
        file = open(query)
        town_dict = JSON.parse(file.read)['feed']
        entries = town_dict['opensearch:totalResults'].to_i
        
        if (entries == 0) then
          
          new_name = ""
          
          if (name.include?("(")) then
            name = name.partition("(").first.rstrip
            puts "Name without () => #{name}"
            new_name = name
          end
          
          if (name == "L'Hospitalet de Llobregat") then
            new_name = "Hospitalet de Llobregat"
          else            
            tokens = name.split
            if (tokens.size > 1) then
              new_name = tokens[1..-1].join(" ")
            elsif (name.include?("'"))
              new_name = name.rpartition("'").last
            end
          end
          
          query = api_url + new_name + options
          query = URI.escape(query)
          puts "New query #{query}"
          file = open(query)
          town_dict = JSON.parse(file.read)['feed']
        end
        
        entry = town_dict['entry']
        entry = entry.first if (entry.class.to_s == "Array") 
        
        puts entry['title']
        content = entry['link']
        href = content["href"]
        start = href.rindex("=") + 1
        town_id = href[start..-1]
      end
    end
  end
  
  puts towns.size
end

fetch_towns_of_catalonia
