class Projections::Scraper

  def self.qb_scraper
    qb_doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/projections/qb.php"))
    qb_doc.css("tr").take(22).drop(2).each do |row|
      player = Projections::Player.new
      player.name = row.css("td")[0].css(".player-name").text
      player.projection = row.css("td")[10].text
      player.url = "https://www.fantasypros.com#{row.css("a").first["href"]}"
        end 
  Projections::Player.url_sub
  end

def self.profile_scraper(player)
    doc = Nokogiri::HTML(open(player.url))
    player.stat_categories = []
    player.stat_totals = []
    player.vitals = doc.css("h5").first.text
    player.week = doc.css(".outlook").css("h4").text
    player.next_game = doc.css(".outlook").css(".next-game").text.strip.gsub("\n",'')
    player.news = doc.css(".content").css("p").first.text
    doc.css(".all-stats").css("th").each do |stat|
      player.stat_categories << stat.text
    doc.css(".all-stats").css("td").each do |stat|
      player.stat_totals << stat.text
      end 
    end
  end 
  end 

