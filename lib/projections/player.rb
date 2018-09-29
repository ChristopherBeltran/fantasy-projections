class Projections::Player
  attr_accessor :qb_hash, :profile_details, :name, :projection, :url, :profile_hash
  
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
  
  def self.display
    x = 1
    @@all.each do |player|
  puts "##{x}. #{player.name}        --------->         Projected Points: #{player.projection}"
      x+=1
    end 
  end 
end 
