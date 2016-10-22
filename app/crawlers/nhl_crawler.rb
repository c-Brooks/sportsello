class NhlCrawler
  include Wombat::Crawler

  def initialize(date)
    @date = date
  end

  base_url "https://ca.sports.yahoo.com/"
  path "/nhl/scoreboard/?date=#{@date}"

  games "css=.game", :iterator do
    date "css=.time"
    team1 "css=.away .team"
    team2 "css=.home"
  end
end
