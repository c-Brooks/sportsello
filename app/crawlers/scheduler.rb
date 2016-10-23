class Scheduler
  # Start crawling games a day in advance
  tomorrow = Date.tomorrow

  # Crawl the all the sports
  nhl_games = NhlCrawler.new(tomorrow).crawl
  nba_games = NbaCrawler.new(tomorrow).crawl
  mlb_games = MlbCrawler.new(tomorrow).crawl

  # Put the data into the database
  nhl_games['games'].each do |game|
    sport = Sport.find_by_name 'NHL'
  end

  nba_games['games'].each do |game|
    sport = Sport.find_by_name 'NBA'
  end  n

  mlb_games['games'].each do |game|
    sport = Sport.find_by_name 'MLB'
  end
end
