class VenuesController < ApplicationController
# This controller deals with putting VENUES on the MAP
  def index
    @query = { day: Date.today, lat: 49.28, lng: -123.1, dist: 1, sport_id: 1 }
    @venues = filter
    @venue_markers = Gmaps4rails.build_markers(@venues) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude
      marker.infowindow gmaps4rails_infowindow(venue)
    end
  end


  def show
    @venue = Venue.find(params[:id])
    @review = Review.new
    @reviews = Review.where(venue_id: params[:id]).order(created_at: :desc)
  end

  def filter
    nearby_venues = Venue.near([@query[:lat], @query[:lng]], @query[:dist])

    nearby_venues.includes(events: [:game])
    .where( "sport_id = ? AND game_datetime > ? AND game_datetime < ?",
          @query[:sport_id],   @query[:day],        @query[:day]+1 )
    .references(:events)
  end

  # I don't know where to put this so it lives here for now
  # It's a method for generating the on-click info on the map markers
  def gmaps4rails_infowindow(venue)
    upcoming_events_string = ""
    # NOTE: The 'Join' button doesn't do anything yet
    upcoming_events(venue).each do |e|
      upcoming_events_string += "<tr>
        <td>#{e.name}</td>
        <td>#{e.game.game_datetime.strftime("%m/%d at %I:%M%p")}</td>
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
      e.game
    end
  end

end
