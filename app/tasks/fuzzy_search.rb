class Fuzzy_Search

  def initialize(query)
    @query = query
    @games = Game.all
    @venues = Venue.all
    @venue_results = []
    @game_results = []
  end

  def searchVenues()
    @venues.each do |venue|
      if search_venue(@query, venue.id)
        @venue_results.push(venue)
      end
    end
  end

  def searchGames()
    @games.each do |game|
      flag = false
      search_sport(@query, game.sport_id).each do |row|
        @game_results.push(game)
        flag = true
      end
      break unless !flag
      search_team(@query, game.sport_id).each do |row|
        @game_results.push(game)
      end
    end
    @game_results
  end

  private
    def search_sport(query, id)
      query = query.split(' ').join('% | %')
      sql = "SELECT id FROM sports WHERE (to_tsvector(name) @@ to_tsquery('#{query}')) AND id = #{id};"
      results = ActiveRecord::Base.connection.execute(sql)
    end

    def search_team(query, id)
      query = query.split(' ').join('% | %')
      sql = "SELECT id FROM teams WHERE (to_tsvector(name) @@ to_tsquery('#{query}')) AND id = #{id};"
      results = ActiveRecord::Base.connection.execute(sql)
    end

    def search_venue(query, id)
      query = query.split(' ').join('% | %')
      sql = "SELECT id FROM venues WHERE (to_tsvector(name) @@ to_tsquery('#{query}')) AND id = #{id};"
      results = ActiveRecord::Base.connection.execute(sql)
    end

end
