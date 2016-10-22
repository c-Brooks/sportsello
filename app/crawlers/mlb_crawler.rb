class MlbCrawler
  # USES YAHOO SPORTS
  include Wombat::Crawler

  def initialize(date)
    @date = date
  end

  def crawl
    get_this_path = "/mlb/scoreboard/?date=#{@date}"

    Wombat.crawl do
      base_url "https://ca.sports.yahoo.com/"
      path get_this_path
      games "css=.game", :iterator do
        date "css=.time"
        # TO-DO GET RID OF JUNK ON TEAM1
        team1 "css=.away"
        team2 "css=.home"
      end
    end
  end

end
