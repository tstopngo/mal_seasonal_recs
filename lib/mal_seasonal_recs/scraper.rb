class MalSeasonalRecs::Scraper

  def self.scrape_page(scrape_url)

    season_page = Nokogiri::HTML(open(scrape_url))
    anime_array = []
    season_page.css(".seasonal-anime.js-seasonal-anime").each do |anime|

      anime_hash = { :title => anime.css("p.title-text a.link-title").text.strip,
                     :episodes => anime.css("div.eps a span").text.strip,
                     :viewers => anime.css("span.member.fl-r").text.strip,
                     :rating => anime.css("span.score").text.strip.to_f.round(1),
                     :summary => anime.css("span.preline").text.strip
                   }
      anime_array << anime_hash
      end
    anime_array
  end

end
