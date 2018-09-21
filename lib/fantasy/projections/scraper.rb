require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
  
@@all = []
  def self.all
    @@all 
  end 
  
def self.qb_scraper
  @doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/projections/qb.php"))
  player_label = @doc.css(".player-label")
player_label.css(".player-name").take(20).each do |player_name|
    @qb_hash = {
    :name => player_name.text
  }
  @@all << @qb_hash
end
end

def self.qb_points_scraper
  x = 14
  if x <= 223
  proj = @doc.css("td")[x].text
  @@all.each do |player|
    player[:projection] = proj
  x += 11
end 
end 
end
end 
Scraper.qb_scraper
Scraper.qb_points_scraper
binding.pry