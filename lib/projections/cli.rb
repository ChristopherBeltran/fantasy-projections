require 'pry'

class Projections::CLI

def call
  Projections::Scraper.scrape_all
  Projections::Player.display
  binding.pry
  end 

def start
  puts "Welcome to Fantasy Quarterbacks!"
  puts "You can view in-depth stats for this weeks top fantasy football quarterbacks."
  puts "Please select the # of the QB you'd like to view stats for."
  
  input = gets.strip
  
  if input == "1"
    overall_list
    
    elsif input == "2"
    position_menu
    
  else
    "Sorry, try again."
  end 
end 
  
end 


