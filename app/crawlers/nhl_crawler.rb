class NhlCrawler
  include Wombat::Crawler

  @date = Date.today

  base_url "https://ca.sports.yahoo.com/"
  path "/nhl/scoreboard/?date=#{@date}"

  games "css=.game", :iterator do
    date "css=.time"
    team1 "css=.away .team"
    team2 "css=.home"
  end
end
