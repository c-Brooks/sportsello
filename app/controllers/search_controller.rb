class SearchController < ApplicationController

   def index
    @games = Fuzzy_Search.new(params[:query]).searchGames
    @venues = Fuzzy_Search.new(params[:query]).searchVenues

    json = Jbuilder.new do |j|
      j.games @games do |game|
        j.game game.id
        j.id game.id
        j.datetime game.game_datetime
        j.team1 Team.find(game.team1_id), :name
        j.team2 Team.find(game.team2_id), :name
        j.sport Sport.find(game.sport_id), :name
      end
      j.venues @venues do |venue|
        j.venue venue.id
        j.name venue.name
        j.description venue.description
        j.address venue.address
        j.website venue.website
      end
    end.target!

    render :json => json
  end

end
