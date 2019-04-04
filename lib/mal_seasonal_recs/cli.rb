class MalSeasonalRecs::CLI

attr_accessor :user_year, :user_season, :scrape_url

  def call
    puts "Welcome to your customized seasonal MAL Recommendations!"
    get_season
    list_anime
  end

  def get_season
    puts "To get started please enter the year for the anime you are interested in"
    @user_year = gets.chomp
    puts "Thanks, now select from season:"
    puts "1. Winter"
    puts "2. Spring"
    puts "3. Summer"
    puts "4. Fall"
    @user_season = gets.chomp
    @scrape_url = "https://myanimelist.net/season/#{@user_year}/#{@user_season}"
  end

  def list_anime

  end

end
