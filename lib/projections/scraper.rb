require 'pry'
require 'nokogiri'
require 'open-uri'
require_relative 'player'

class Projections::Scraper
  
  def self.scrape_all
    self.qb_scraper
    self.qb_points_scraper
    self.url_scraper
  end 
  
 def self.qb_scraper
    @qb_doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/projections/qb.php"))
    player_label = @qb_doc.css(".player-label")
    player_label.css(".player-name").take(20).each do |player_name|
      player = Projections::Player.new
      player.name = player_name.text
    end
  end

  def self.qb_points_scraper
  points_columns = [14,25,36,47,58,69,80,91,102,113,124,135,146,157,168,179,190,201,212,223]
    Projections::Player.all.zip(points_columns).each do |player, proj|
      player.projection = @qb_doc.css("td")[proj].text
    end 
  end
  
  def self.url_scraper
    links = @qb_doc.css('td.player-label a').take(40).map { |link| link['href'] }
    pro = []
   links.each do |i| 
     if i.include? "php"
       pro << i
     end 
     Projections::Player.all.zip(pro).each do |player, link|
      player.url = "https://www.fantasypros.com#{link}"
    end 
  Projections::Player.url_sub
  end

 
  
  def self.profile_scraper(player)
    @doc = Nokogiri::HTML(open(player.url))
    player.stat_categories = []
    player.stat_totals = []
    player.vitals = @doc.css("h5").first.text
    player.week = @doc.css(".outlook").css("h4").text
    player.next_game = @doc.css(".outlook").css(".next-game").text.strip.gsub("\n",'')
    player.news = @doc.css(".content").css("p").first.text
    @doc.css(".all-stats").css("th").each do |stat|
      player.stat_categories << stat.text
    @doc.css(".all-stats").css("td").each do |stat|
      player.stat_totals << stat.text
      end 
    end
  end 
  end 

end 
