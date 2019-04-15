class MalSeasonalRecs::CLI

attr_reader :filtered_anime_list

SCRAPE_URL= "https://myanimelist.net/anime/season/"

  def call
    puts "Welcome to your customized seasonal MAL Recommendations!"
    puts " "
    make_season_list
    list_anime
    user_options
  end

  def make_season_list
    puts "To get started please enter the year you are interested in: "
    user_year = gets.strip
    while user_year.to_i >= Date.today.year
      puts "Yikes! We haven't forseen that far into the future yet for rated anime.（ｉДｉ）\nPlease try a different year:"
      user_year = gets.strip
    end


    season_array = ["Winter", "Spring", "Summer", "Fall"]

    puts "Thanks, please enter a number for a season:"
    puts "1. #{season_array[0]}"
    puts "2. #{season_array[1]}"
    puts "3. #{season_array[2]}"
    puts "4. #{season_array[3]}"

    user_season = gets.strip.to_i

    while user_season > season_array.length
      puts "Hmm...that's not a season (￢ε￢　)\nPlease try again:"
      puts "1. #{season_array[0]}"
      puts "2. #{season_array[1]}"
      puts "3. #{season_array[2]}"
      puts "4. #{season_array[3]}"
      user_season = gets.strip.to_i
    end

      test_scrape = SCRAPE_URL + "#{user_year}/#{season_array[user_season-1]}"
      anime_list_array = MalSeasonalRecs::Scraper.scrape_page(SCRAPE_URL + "#{user_year}/#{season_array[user_season-1].downcase}")
      MalSeasonalRecs::Anime.create_anime_list(anime_list_array)

  end


  def list_anime
   puts "Here's the list of anime for that season:"
     MalSeasonalRecs::Anime.all.each_with_index do |anime, index|
      puts "#{index+1}. #{anime.title}".colorize(:cyan)
      puts "  Episodes:".colorize(:light_cyan) + " #{anime.episodes}"
      puts "  Viewers:".colorize(:light_cyan) + " #{anime.viewers}"
      puts "  Rating:".colorize(:light_cyan) + " #{anime.rating}"
      puts "----------------------".colorize(:green)
    end
  end

  def  user_options
    puts "What would you like to do? Enter a number:"
    puts "1. Filter List"
    puts "2. Get Show Info"
    puts "3. Exit"
    user_selection = gets.strip
    case user_selection
      when  "1"
        filter_list_by?
      when "2"
        show_more_info_unfiltered
        exit
      when "3"
        exit
      else
        puts "Sorry, I don't understand that. Can you try again?"
        user_options
    end
  end

  def filter_list_by?
    puts "How would you like to filter your results? Enter a number:"
    puts "1. By Rating"
    puts "2. By Number of Episodes"
    puts "3. Return to List"

    user_selection = gets.strip
    case user_selection
      when "1"
        filter_by_rating
        show_more_info_filtered
        exit
      when "2"
        filter_by_episode_length
        show_more_info_filtered
        exit
      when "3"
        list_anime
        user_options
      else
        puts "Sorry, I don't understand that. Can you try again?"
        filter_list
      end
  end


  def filter_by_rating
    puts "What is the minimum rating for the anime? Enter 1.0-10.0:"
    user_rating = gets.strip.to_f
      @filtered_anime_list = []

    puts "Here are your filtered shows:"
    if user_rating.between?(0.0,10.0)
      MalSeasonalRecs::Anime.all.sort_by{|anime| anime.rating}.each_with_index do |anime|
        if anime.rating >= user_rating
          @filtered_anime_list << anime
          puts "#{@filtered_anime_list.length}. #{anime.title}".colorize(:cyan)
          puts "  Episodes:".colorize(:light_cyan) + " #{anime.episodes}"
          puts "  Viewers:".colorize(:light_cyan) + " #{anime.viewers}"
          puts "  Rating:".colorize(:light_cyan) + " #{anime.rating}"
          puts "----------------------".colorize(:green)
        end
      end
    else
      puts "Sorry! That's not a valid entry, please try again. Σ(･口･)"
      filter_by_rating
    end
    @filtered_anime_list
  end

  def filter_by_episode_length
    puts "What is the minimum number of episodes? Enter 1-200"
    user_episodes = gets.strip.to_i
      @filtered_anime_list = []

    puts "Here are your filtered shows:"
    if user_episodes.between?(1,200)
      MalSeasonalRecs::Anime.all.sort_by{|anime| anime.rating}.each_with_index do |anime|
        if anime.episodes.gsub(/\D/, '').to_i >= user_episodes
          @filtered_anime_list << anime
          puts "#{@filtered_anime_list.length}. #{anime.title}".colorize(:cyan)
          puts "  Episodes:".colorize(:light_cyan) + " #{anime.episodes}"
          puts "  Viewers:".colorize(:light_cyan) + " #{anime.viewers}"
          puts "  Rating:".colorize(:light_cyan) + " #{anime.rating}"
          puts "----------------------".colorize(:green)
        end
      end
    else
      puts "Sorry! That's not a valid entry, please try again. Σ(･口･)"
      filter_by_episode_length
    end
    @filtered_anime_list
  end

  def show_more_info_filtered
    puts "Enter the number of the show you would like to get more info on:"
      user_selection = gets.strip.to_i
    while user_selection != 0
      anime = @filtered_anime_list[user_selection-1]
      puts "#{anime.title}".colorize(:cyan)
      puts "  Summary:".colorize(:light_cyan) + " #{anime.summary}"
      puts "\nEnter another number or type 'done' "
      user_selection = gets.strip.to_i
    end
  end

  def show_more_info_unfiltered
    puts "Enter the number of the show you would like to get more info on:"
      user_selection = gets.strip.to_i
    while user_selection != 0
      anime = MalSeasonalRecs::Anime.all[user_selection-1]
      puts "#{anime.title}".colorize(:cyan)
      puts "  Summary:".colorize(:light_cyan) + " #{anime.summary}"
      puts "\nEnter another number or type 'done' "
      user_selection = gets.strip.to_i
    end
  end

  def exit
    puts "\nLater! ʕノ•ᴥ•ʔノ ︵ ┻━┻"
  end

end
