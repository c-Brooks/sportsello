class NhlCrawler
  include Wombat::Crawler

  def initialize(date)
    @date = date
  end

  def crawl
    get_this_path = "/nhl/scoreboard/?date=#{@date}"

    Wombat.crawl do
      base_url "https://ca.sports.yahoo.com/"
      path get_this_path
      games "css=.game", :iterator do
        date "css=.time"
        team1 "css=.away .team"
        team2 "css=.home"
      end
    end
  end

end
