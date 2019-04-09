class MalSeasonalRecs::Scraper

  def self.scrape_page(scrape_url)

    season_page = Nokogiri::HTML(open(scrape_url))
    anime_array = []
    season_page.css(".seasonal-anime.js-seasonal-anime").each do |anime|

      anime_hash = { :title => anime.css("p.title-text a.link-title").text.chomp,
                     :episodes => anime.css("div.eps a span").text.chomp,
                     :viewers => anime.css("span.member.fl-r").text.chomp,
                     :rating => anime.css("span.score").text.chomp
                   }
      anime_array << anime_hash
      end
    anime_array
  end

end
