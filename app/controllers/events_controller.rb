class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def attending
    Attendee.create(attendee_params)
  end

  private
    def attendee_params
      params.require(:attendee).permit(:user_id, :event_id)
    end
end
