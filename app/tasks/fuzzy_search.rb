class Fuzzy_Search

  def initialize(query)
    @query = query
    @games = Game.all
    @venues = Venue.all
    @events = Event.all
    @sports = Sport.all
    @venue_results = []
    @event_results = []
    @game_results = []
  end

  def searchVenues()
    @venues.each do |venue|
      search_table(@query, venue.id, 'venues').each do |row|
        @venue_results.push(venue)
      end
    end
    @venue_results
  end

  # def searchEvents()
  #   @events.each do |event|
  #     event_game = Game.find(event.game_id)
  #     flag = false
  #     # if event_game.sport_id <= @sports.length
  #     #   search_table(@query, event_game.sport_id, 'sports').each do |row|
  #     #     @event_results.push(event)
  #     #     flag = true
  #     #   end
  #     # end
  #     # next unless !flag
  #       search_table(@query, event_game.team1_id, 'teams').each do |row|
  #         @event_results.push(event)
  #         flag = true
  #       end
  #     next unless !flag
  #       search_table(@query, event_game.team2_id, 'teams').each do |row|
  #         @event_results.push(event)
  #         flag = true
  #       end
  #     next unless !flag
  #       search_table(@query, event.venue_id, 'venues').each do |row|
  #         @event_results.push(event)
  #       end
  #   end
  #   @event_results
  # end

  def searchGames()
    @games.each do |game|
      flag = false
      if game.sport_id <= @sports.length
        search_table(@query, game.sport_id, 'sports').each do |row|
          @game_results.push(game)
          flag = true
        end
      end
      next unless !flag
      search_table(@query, game.team1_id, 'teams').each do |row|
        @game_results.push(game)
        flag = true
      end
      next unless !flag
      search_table(@query, game.team2_id, 'teams').each do |row|
        @game_results.push(game)
      end
    end
    @game_results
  end

  private
    def search_table(query, id, table)
      if id != nil
        query = query.split(' ').join('% | %')
        sql = "SELECT id FROM #{table} WHERE (to_tsvector(name) @@ to_tsquery('#{query}')) AND id = #{id};"
        results = ActiveRecord::Base.connection.execute(sql)
      else
        []
      end
    end

end
