class GamesController < ApplicationController
  def index
    @games = Game.all.order('game_datetime ASC').where("game_datetime >= ?", params['game_datetime']).limit(10)

    json = Jbuilder.new do |j|
      j.games @games do |game|
        j.game game.id
        j.datetime game.game_datetime
        j.team1 Team.find(game.team1_id), :name
        j.team2 Team.find(game.team2_id), :name
        j.sport Sport.find(game.sport_id), :name
     end
    end.target!
    respond_to do |format|
      format.html
      format.js
      format.json { render :json => json }
    end
  end
end
