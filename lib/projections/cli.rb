class Projections::CLI

def call
  Projections::Scraper.scrape_all
  start
  quit
  end 

def start
  puts "----------------------------------------------------------------------------"
  puts "                   Welcome to Fantasy Quarterbacks!                         "
  puts "You can view stats & news for this weeks top fantasy football quarterbacks."
  puts "----------------------------------------------------------------------------"
  display
  puts "----------------------------------------------------------------------------"
  puts "Please select the # of the QB you'd like to view stats for. Or type 0 to exit."
  puts "----------------------------------------------------------------------------" 
   
  input = gets.chomp
  if input == "0"
    self.quit
    
  elsif input.to_i.between?(1, 20)
    qb = Projections::Player.all[input.to_i-1]
      if qb.vitals == nil
      Projections::Scraper.profile_scraper(qb)
      profile_display(qb)
      else
      profile_display(qb)
      end 
  else 
    puts "Sorry, can you try that again?"
    self.start
  end 
end 
  
  def display
    x = 1
    Projections::Player.all.each do |player|
    puts "##{x}." + " #{player.name}".colorize(:light_blue) + "        --------->         Projected Points: #{player.projection}".colorize(:green)
      x+=1
    end 
  end 
  
  def profile_display(player)
    puts "----------------------------------------------------------------------------".colorize(:cyan)
    puts "#{player.name}".upcase + "                                        NEXT GAME:"
    puts "#{player.vitals}".upcase + "                            #{player.next_game}"
    puts "----------------------------------------------------------------------------".colorize(:cyan)
    puts "                           #{player.week}".upcase
    puts "----------------------------------------------------------------------------".colorize(:cyan)
    player.stat_categories.zip(player.stat_totals).each do |cat, tot|
    puts "#{cat}\n".colorize(:red) + 
          "#{tot}".colorize(:green)
    end 
    puts "----------------------------------------------------------------------------".colorize(:cyan)
    puts "                            THIS WEEKS NEWS                                 "
    puts "----------------------------------------------------------------------------".colorize(:cyan)
    puts "#{player.news}".colorize(:yellow)
    puts "----------------------------------------------------------------------------".colorize(:cyan)
    puts "Press 1 to return to the Main Menu, or type 2 to quit"
    input = gets.chomp
    if input == "1"
      self.start
    elsif input == "2"
    self.quit
  else 
      until input == "1" || input == "2"
      puts "Woops, try again."
          input = gets.chomp
  end 
end 

end 

def quit
  puts "See you next week!"
  exit 
end 
end 
