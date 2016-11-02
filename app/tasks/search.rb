class Search

  def initialize(query)
    this.query = query
    @games = Game.all
    @venues = Venue.all
    @venue_results = []
    @game_results = []
  end

  def searchVenues(query)
    @venues.each do |venue|
      if search_venue(query, venue.id)
        @venue_results.push(venue)
      end
    end
  end

  def searchGames(query)
    @games.each do |game|
      if
      search_sport(query, game.sport_id) ||
      search_team(query, game.team1_id) ||
      search_team(query, game.team2_id)
        @game_results.push(game)
      end
    end
  end

  private
    def search_sport(query, id)
      query = query.split(' ').join('% | %')
      sql = "Select id from sports where to_tsvector(name) @@ to_tsquery('#{query}');"
      records_array = ActiveRecord::Base.connection.execute(sql)
      records_array.include? id
    end

    def search_team(query, id)
      query = query.split(' ').join('% | %')
      sql = "Select id from teams where to_tsvector(name) @@ to_tsquery('#{query}');"
      records_array = ActiveRecord::Base.connection.execute(sql)
      records_array.include? id
    end

    def search_venue(query, id)
      query = query.split(' ').join('% | %')
      sql = "Select id from venues where to_tsvector(name) @@ to_tsquery('#{query}');"
      records_array = ActiveRecord::Base.connection.execute(sql)
      records_array.include? id
    end

end
