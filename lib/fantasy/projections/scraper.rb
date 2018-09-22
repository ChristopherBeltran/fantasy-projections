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
  points = []
  points_columns = [14,25,36,47,58,69,80,91,102,113,124,135,146,157,168,179,190,201,212,223]
  points_columns.each do |x|
    points << @doc.css("td")[x].text
  end 
  @@all.zip(points).each do |player, proj|
    player[:projection] = proj
  end 
end
end