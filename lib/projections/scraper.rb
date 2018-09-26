class Projections::Scraper
  
@@all = []

 def self.qb_scraper
    @qb_doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/projections/qb.php"))
    player_label = @qb_doc.css(".player-label")
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
      player[:projection] = @qb_doc.css("td")[proj].text
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
  binding.pry