class GamesController < ApplicationController

  def index
    @games = Game.all.order('game_datetime ASC').where("game_datetime >= ?", params['game_datetime']).limit(25)

    json = Jbuilder.new do |j|
      j.games @games do |game|
        j.game game.id
        j.id game.id
        j.datetime game.game_datetime
        j.team1 Team.find(game.team1_id), :name
        j.team2 Team.find(game.team2_id), :name
        j.sport Sport.find(game.sport_id), :name
     end
    end.target!

    render :json => json
  end

  def show
    @game = Game.find params[:id]

    @game_json = Jbuilder.new do |j|
      j.datetime @game.game_datetime
      j.team1 Team.find(@game.team1_id), :name
      j.team2 Team.find(@game.team2_id), :name
      j.sport Sport.find(@game.sport_id), :name
      j.events Event.where(game_id: params[:id]) do |event|
        j.event event.id
        j.id event.id
        j.name event.name
        j.venue Venue.find(event.venue_id)
        j.attendees Attendee.where(event_id: event.id).pluck(:user_id)
        j.users Attendee.find_by(event_id: event.id) ?
        Attendee.find_by(event_id: event.id).user : []
      end
    end.target!

    render :json => @game_json
  end

end
