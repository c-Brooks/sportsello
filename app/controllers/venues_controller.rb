class VenuesController < ApplicationController
# This controller deals with putting VENUES on the MAP
  def index
    @query = {
      day: params[:day] ? Date.parse(params[:day]) : Date.today,
      lat: 49.28,
      lng: -123.1,
      dist: 5,
      sport_id: params[:sport_id] || 1
    }
    @venues = filter
    @venue_markers = Gmaps4rails.build_markers(@venues) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude
      marker.infowindow gmaps4rails_infowindow(venue)
    end
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      render json: @venue
    else
      render json: @venue.errors
    end
  end

  def show
    @venue = Venue.find params[:id]

    @venue_json = Jbuilder.new do |j|
      j.id @venue.id
      j.name @venue.name
      j.description @venue.description
      j.address @venue.address
      j.latitude @venue.latitude
      j.longitude @venue.longitude
      j.reviews Review.where(venue_id: params[:id]).order(created_at: :desc) do |review|
        j.review review.id
        j.rating review.rating
        j.description review.description
        j.user User.find(review.user_id), :name
        j.created_at review.created_at
      end
    end.target!

    render :json => @venue_json
  end

  def filter
    nearby_venues = Venue.near([@query[:lat], @query[:lng]], @query[:dist])
    # games = Game.where(event_id: )
    # nearby_venues.includes(:events)
    # .where( "game_datetime > ? AND game_datetime < ?",
    #         @query[:day],        @query[:day]+1 )
    # .references(:events)
  end

  # I don't know where to put this so it lives here for now
  # It's a method for generating the on-click info on the map markers
  def gmaps4rails_infowindow(venue)
    upcoming_events_string = ""
    # NOTE: The 'Join' button doesn't do anything yet
    upcoming_events(venue).each do |e|
      game = Game.find(e.game_id)
      upcoming_events_string += "<tr>
        <td>#{e.name}</td>
        <td>#{game.game_datetime.strftime("%m/%d at %I:%M%p")}</td>
        <td><button class='btn btn-info btn-sm map-rsvp-btn'>Join!</td>
      </tr>"
    end
      "
      <h4>
        #{venue.name.upcase!}
      </h4>
      <h5>
        #{venue.address} -
        <a href=#{venue.website} class='glyphicon glyphicon-info-sign'></a>
      </h5>
      <p>
        #{venue.description}
      </p>
      <table class='table'>
      <h5>Upcoming: </h5>
        #{upcoming_events_string}
      </table>
      "
  end

  # Select next 3 upcoming events
  def upcoming_events(venue)
    venue.events.each do |e|
      Game.find(e.game_id)
    end
  end

  def user_venues
    @venues = Venue.where(user_id: params[:user_id])
    render json: @venues
  end

  def destroy
    @venues = Venue.find(params[:id]).destroy
    render json: @venues
  end

private
  def venue_params
    params.permit(:user_id, :name, :website, :address, :description)
  end

end
