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
player_label.css(".player-name").take(20).each do |player_name|
    qb_hash = {
    :name => player_name.text
  }
  @@all << qb_hash
end
@@all
binding.pry
end 
end

Scraper.qb_scraper