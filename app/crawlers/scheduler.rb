class Scheduler
  def initialize
    # Start crawling games a day in advance
    @tomorrow = Date.tomorrow

    # Crawl the all the sports
    @nhl_games = NhlCrawler.new(@tomorrow).crawl
    @nba_games = NbaCrawler.new(@tomorrow).crawl
    @mlb_games = MlbCrawler.new(@tomorrow).crawl

    # Go through each group of games
    @nhl_games['games'].each do |game|
      @sport = Sport.find_by_name 'NHL'
      add_game(game, @sport)
    end

    @nba_games['games'].each do |game|
      @sport = Sport.find_by_name 'NBA'
      add_game(game, @sport)
    end

    @mlb_games['games'].each do |game|
      @sport = Sport.find_by_name 'MLB'
      add_game(game, @sport)
    end
  end

  private

  # Add game to database
  def add_game(game, sport)
    # Find teams or creat them if they don't exist
    @team1 = Team.find_or_create_by name: game['team1']
    @team2 = Team.find_or_create_by name: game['team2']

    Game.create({
      sport_id: sport.id,
      team1_id: @team1.id,
      team2_id: @team2.id,
      game_datetime: game['date']
    })
  end

end
