class FantasyProjections::CLI

def call
  FantasyProjections::Scraper.new.make_list
  puts "Welcome to Fantasy Football Projections!"
  start
end 

def start
  puts "You can view the upcoming weeks projections for the top players."
  puts "Would you like to view the top overall player projections? Press 1"
  puts "Or would you like to view top player projections by position? Press 2"
  
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







end 

