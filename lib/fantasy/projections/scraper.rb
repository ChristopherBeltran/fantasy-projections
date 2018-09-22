require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
  attr_accessor :qb_hash, :rb_hash
  
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
  points_columns = [14,25,36,47,58,69,80,91,102,113,124,135,146,157,168,179,190,201,212,223]
  @@all.zip(points_columns).each do |player, proj|
    player[:projection] = @doc.css("td")[proj].text
  end 
end

def self.rb_scraper
  @doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/projections/rb.php"))
  player_label = @doc.css(".player-label")
player_label.css(".player-name").take(30).each do |player_name|
    @rb_hash = {
    :name => player_name.text
  }
  @@all << @rb_hash
end
end

def self.rb_points_scraper
  points_columns = [12,21,30,39,48,57,66,75,84,93,102,111,120,129,138,147,156,165,174,183,192,201,210,219,228,237,246,255,264,273]
  @@all.zip(points_columns).each do |player, proj|
    player[:projection] = @doc.css("td")[proj].text
  end 
end
end
end
Scraper.qb_scraper
Scraper.qb_points_scraper
Scraper.rb_scraper
Scraper.rb_points_scraper
binding.pry