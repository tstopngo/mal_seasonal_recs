class MalSeasonalRecs::Anime
  attr_accessor :title, :episodes, :viewers, :rating, :summary

  @@all = []

  def initialize(anime_hash)
    anime_hash.each{|attribute, data| self.send(("#{attribute}="), data)}
    @@all << self
  end

  def self.create_anime_list(anime_list_array)
    anime_list_array.each do |anime|
      MalSeasonalRecs::Anime.new(anime)
    end
  end

  def self.all
    @@all
  end

end
