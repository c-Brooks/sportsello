class GetGames

  def initialize
    @tomorrow = Date.tomorrow
    # Set future to 30 days in advance
    @future = @tomorrow + 30.days
  end

  def crawl
    # Start crawling games a day in advance
    @tomorrow.upto(@future) do |date|
      #Crawl all the sports
      nhl_games = NhlCrawler.new(date).crawl
      nba_games = NbaCrawler.new(date).crawl
      mlb_games = MlbCrawler.new(date).crawl
      nfl_games = NflCrawler.new(date).crawl
      fifa_games = FifaCrawler.new(20161106).crawl

      # Go through each group of games
      nhl_games['games'].each do |game|
        sport = Sport.find_by_name 'NHL'
        add_game(game, sport, date)
      end

      nba_games['games'].each do |game|
        sport = Sport.find_by_name 'NBA'
        add_game(game, sport, date)
      end

      mlb_games['games'].each do |game|
        sport = Sport.find_by_name 'MLB'
        #Takes team data and splits into proper string
        game['team1'] = game['team1'].split(') ')[1].split("\n")[0]
        game['team2'] = game['team2'].split(') ')[1]
        add_game(game, sport, date)
      end

      nfl_games['games'].each do |game|
        sport = Sport.find_or_create_by name: 'NFL'
        #Takes team data and splits into proper string
        game['team1'] = game['team1'].split(' at ')[0]
        game['team2'] = game['team2'].split(' at ')[1]
        #Takes date data and grabs nested data
        game['date'] = game['date'][0]['actual_date']
        add_game(game, sport, date)
      end

      fifa_games['games'].each do |game|
        sport = Sport.find_or_create_by name: 'FIFA'
        #Takes team/date data and grabs nested name
        game['team1'] = game['teams'][0]['team']
        game['team2'] = game['teams'][1]['team']
        game['date'] = game['date'][0]['date_time']
        add_game(game, sport, date)
      end

    end
  end

  private

  # Add game to database
  def add_game(game, sport, date)
    # Format date
    if sport.name != 'NFL' || sport.name != 'FIFA'
      game['date'] = date.to_s + ' ' + game['date']
    end

    # Find teams or create them if they don't exist
    team1 = Team.find_or_create_by name: game['team1']
    team2 = Team.find_or_create_by name: game['team2']

    begin
      Game.create({
        sport_id: sport.id,
        team1_id: team1.id,
        team2_id: team2.id,
        game_datetime: game['date']
      })
    rescue => e
      puts e.message
      puts "Ignoring existing game..."
    end

  end

end
