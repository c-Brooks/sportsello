class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def top
    @events = Event.joins(:attendees).distinct.select('events.*, COUNT(attendees.*) AS attendee_count').group('events.id').limit(10)
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

  private
    def attendee_params
      params.permit(:user_id, :event_id)
    end
end
