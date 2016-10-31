class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def attending
    @attendee = Attendee.create(attendee_params)

    render json: @attendee
  end

  private
    def attendee_params
      params.permit(:user_id, :event_id)
    end
end
