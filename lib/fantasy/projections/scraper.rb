require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
  
@@all = []
  def self.all
    @@all 
  end 
  
def self.qb_scraper
  doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/projections/qb.php"))
  player_label = doc.css(".player-label")
player_label.css(".player-name").each do |player_name|
    counter = 0
until counter == 20
  qb_hash = {
    :name => player_name.text
  }
  counter += 1
  @@all << qb_hash
end
end
@@all
binding.pry
end 
end

Scraper.qb_scraper