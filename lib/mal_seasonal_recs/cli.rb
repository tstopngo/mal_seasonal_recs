class MalSeasonalRecs::CLI

SCRAPE_URL= "https://myanimelist.net/anime/season/"

  def call
    puts "Welcome to your customized seasonal MAL Recommendations!"
    puts " "
    make_season_list
    list_anime
    filter_list
  end

  def make_season_list
    puts "To get started please enter the year you are interested in: "
    user_year = gets.strip.chomp
    puts "Thanks, please select from a season:"
    puts "1. Winter"
    puts "2. Spring"
    puts "3. Summer"
    puts "4. Fall"
    season_array = ["winter", "spring", "summer", "fall"]
    user_season = gets.strip.chomp.to_i
    anime_list_array = MalSeasonalRecs::Scraper.scrape_page(SCRAPE_URL + "#{user_year}/#{season_array[user_season]}")
    MalSeasonalRecs::Anime.create_anime_list(anime_list_array)
  end

  def list_anime
   puts "Here's the list of anime for that season:"

   MalSeasonalRecs::Anime.all.each do |anime|
     puts "#{anime.title}".colorize(:blue)
     puts "  episodes:".colorize(:light_blue) + " #{anime.episodes}"
     puts "  viewers".colorize(:light_blue) + " #{anime.viewers}"
     puts "  rating:".colorize(:light_blue) + " #{anime.rating}"
     puts "----------------------".colorize(:green)
   end
  end


  def filter_list
    puts "How would you like to filter your results?"
    puts "1. By Rating"
    puts "2. By Episode Length"

    user_input = nil
    while user_input != "exit"
      case user_input
      when "1"
        filter_by_rating
      when "2"
        filter_by_episode_length
      end
    end
  end

  def filter_by_rating

  end

  def filter_by_episode_length

  end

  def exit
    puts "Ja ne!"
  end

end
