class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def top
    @events = Event.distinct.select('events.*, COUNT(attendees.*) AS attendee_count')
      .joins("LEFT OUTER JOIN attendees ON attendees.event_id = events.id")
      .joins("INNER JOIN games ON games.id = events.game_id")
      .group('events.id')
      .where("game_datetime >= ?", params['game_datetime'])
      .order('attendee_count DESC')
      .limit(10)

    render json: @events
  end

  def attending
    @attendee = Attendee.create(attendee_params)
    render json: @attendee
  end

  def cancel_rsvp
    @attendee = Attendee.where(attendee_params).destroy_all
    render json: @attendee
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event
    else
      render json: @event.errors
    end
  end

  private
    def attendee_params
      params.permit(:user_id, :event_id)
    end

    def event_params
      params.permit(:name, :game_id, :venue_id)
    end
end
