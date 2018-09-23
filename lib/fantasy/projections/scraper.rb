require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
  
@@all = []

  def self.scrape_all
    self.qb_scraper
    self.qb_points_scraper
    self.rb_scraper
    self.rb_points_scraper
    self.wr_scraper
    self.wr_points_scraper
    self.te_scraper
    self.te_points_scraper
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
     @@all[20..49].zip(points_columns).each do |player, proj|
       player[:projection] = @doc.css("td")[proj].text
       end 
  end
  
  def self.wr_scraper
  @doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/projections/wr.php"))
    player_label = @doc.css(".player-label")
    player_label.css(".player-name").take(30).each do |player_name|
    @wr_hash = {
    :name => player_name.text
    }
    @@all << @wr_hash
    end
  end

  def self.wr_points_scraper
  points_columns = [12,21,30,39,48,57,66,75,84,93,102,111,120,129,138,147,156,165,174,183,192,201,210,219,228,237,246,255,264,273]
     @@all[50..79].zip(points_columns).each do |player, proj|
       player[:projection] = @doc.css("td")[proj].text
       end 
  end
  
  def self.te_scraper
  @doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/projections/te.php"))
    player_label = @doc.css(".player-label")
    player_label.css(".player-name").take(15).each do |player_name|
    @te_hash = {
    :name => player_name.text
    }
    @@all << @te_hash
    end
  end

  def self.te_points_scraper
  points_columns = [8,14,20,26,32,38,44,50,56,62,68,74,80,86,92]
     @@all[80..94].zip(points_columns).each do |player, proj|
       player[:projection] = @doc.css("td")[proj].text
       end 
  end
  
  def self.profile_scraper(player)
    @doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/players/#{player}.php"))
    @profile_hash = {}
    @profile_hash[:week] = @doc.css(".outlook").css("h4").text
    @profile_hash[:next_game] = @doc.css(".outlook").css(".next-game").text.strip.gsub("\n",'')
    @profile_hash[:news] = @doc.css(".content").css("p").first.text
    stat_names = []
    @doc.css(".all-stats").css("th").each do |stat|
      stat_names << stat.text
    @profile_hash[:stat_categories] = stat_names
    stat_contents = []
    @doc.css(".all-stats").css("td").each do |stat|
      stat_contents << stat.text
    @profile_hash[:stat_totals] = stat_contents
      end 
    end
    @profile_hash
  end 
  end 
  