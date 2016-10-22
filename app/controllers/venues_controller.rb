class VenuesController < ApplicationController
# This controller deals with putting VENUES on the MAP
  def index
    @venues = Venue.all
    @venue_markers = Gmaps4rails.build_markers(@venues) do |venue, marker|
      marker.lat venue.latitiude
      marker.lng venue.longitude
      marker.infowindow venue.name
    end
  end

end
