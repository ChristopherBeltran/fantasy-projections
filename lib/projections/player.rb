class Projections::Player
  attr_accessor :qb_hash, :profile_details, :name, :projection, :url, :vitals, :week, :next_game, :news, :stat_categories, :stat_totals
  
@@all = []

  def initialize(name = nil, projection = nil, url = nil, profile_details = nil)
    @name = name
    @projection = projection
    @url = url
    @profile_details = profile_details
    @@all << self 
  end
  
  def self.all
    @@all
  end 
  
  def self.url_sub
    @@all.each do |player|
      player.url.gsub!("projections", "players")
    end 
  end 
  
end 
