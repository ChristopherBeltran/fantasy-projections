require 'pry'

class Projections::CLI

def call
  Projections::Scraper.scrape_all
  start
  binding.pry
  end 

def start
  puts "Welcome to Fantasy Quarterbacks!"
  puts "You can view in-depth stats for this weeks top fantasy football quarterbacks."
  puts "Please select the # of the QB you'd like to view stats for."
  Projections::Player.display
  
  input = gets.chomp.to_i
  qb = Projections::Player.all[input-1]
  
  Projections::Scraper.profile_scraper(qb)
    
end 
  
end 


