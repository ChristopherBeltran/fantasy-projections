class Player
  attr_accessor :qb_hash, :profile_hash, :name, :projection
  
@@all = []

  def initialize(name = nil, projection = nil)
    @name = name
    @projection = projection
    @@all << self 
  
  end
  
  def self.all
    @@all
  end 

end 
