#!env ruby

require 'rubygems'
require 'mechanize'
require 'uri'
require 'open-uri'
require 'json'
require 'sqlite3'

class Town

	attr_accessor	:name, :lat, :lon, :home0, :home1, :home2, :home3, :home4, :dona0, :dona1, :dona2, :dona3, :dona4
	
	def initialize()
  end
	
	def to_s
	  "#{@name} Lat:#{@lat} -- Lon:#{@lon}"
  end
  
  def to_insert
    "insert into towns values(\"#{@name}\", #{@lat}, #{@lon}, #{@home0}, #{@home1}, #{@home2}, #{@home3}, #{@home4}, #{@dona0}, #{@dona1}, #{@dona2}, #{@dona3}, #{@dona4})"
  end

end

def fetch_towns_of_catalonia
  towns = Array.new

  db = SQLite3::Database.new("towns.db")
  db.execute("create table towns(name varchar(100), lat float, lon float, home0 int, home1 int, home2 int, home3 int, hometotal int, dona0 int, dona1 int, dona2 int, dona3 int, donatotal int)")
  
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
        
        content = entry['link']
        href = content["href"]
        start = href.rindex("=") + 1
        town_id = href[start..-1]
        
        data_url = "http://api.idescat.cat/emex/v1/dades.json?id=" + town_id + "&i=f328,f329,f176,f33,f34,f35,f36,f38,f39,f40,f41,f42"
        puts data_url
        data_file = open(data_url)
        town_data = JSON.parse(data_file.read)
        
        town = Town.new
        town_data["fitxes"]["indicadors"]["i"].each do |elem|
          town.name = name
          
          id = elem["id"]
          value = elem["v"].split(',').first
          
          if (id == "f328") then
            town.lon = value.to_f
          elsif (id == "f329")
            town.lat = value.to_f
          elsif (id == "f176")
            town.home0 = value.to_i
          elsif (id == "f33")
            town.home1 = value.to_i
          elsif (id == "f34")
            town.home2 = value.to_i
          elsif (id == "f35")
            town.home3 = value.to_i
          elsif (id == "f36")
            town.home4 = value.to_i
          elsif (id == "f38")
            town.dona0 = value.to_i
          elsif (id == "f39")
            town.dona1 = value.to_i
          elsif (id == "f40")
            town.dona2 = value.to_i
          elsif (id == "f41")
            town.dona3 = value.to_i
          elsif (id == "f42")
            town.dona4 = value.to_i
          end
        end
        puts town.to_insert
        db.execute(town.to_insert)
      end
    end
  end
  
  puts towns.size
end

fetch_towns_of_catalonia
