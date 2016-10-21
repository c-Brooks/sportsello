class NhlCrawler
  include Wombat::Crawler

  base_url "https://ca.sports.yahoo.com/"
  path "/nhl/scoreboard/"

  game "css=.game td", :list
end
