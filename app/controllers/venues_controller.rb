class VenuesController < ApplicationController
# This controller deals with putting VENUES on the MAP
  def index
    @query = { day: Date.today, lat: 49.28, lng: -123.1 }
    @venues = filter(@query)
    @venue_markers = Gmaps4rails.build_markers(@venues) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude
      marker.infowindow gmaps4rails_infowindow(venue)
    end
  end

  # Filter by DAY, EVENT, SPORT, LOCATION (dist. from pt.)
  def filter(query)
    Venue.near([query[:lat], query[:lng]], 100)#.where("DATE(event_datetime) = Date.today")
  end

  # I don't know where to put this so it lives here for now
  # It's a method for generating the on-click info on the map markers
  def gmaps4rails_infowindow(venue)
    upcoming_events_string = ""
    upcoming_events(venue).each do |e|
      upcoming_events_string += "<tr>
        <td>#{e.name}</td>
        <td>#{e.event_datetime.strftime("%m/%d at %I:%M%p")}</td>
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
        #{upcoming_events_string}
      </table>
      "
  end

  # Select next 3 upcoming events
  def upcoming_events(venue)
    venue.events.all.order(:event_datetime).limit(3)
  end

end
