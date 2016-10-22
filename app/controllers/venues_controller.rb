class VenuesController < ApplicationController

  def index
    @venues = Venue.all
    @hash = Gmaps4rails.build_markers(@venues) do |venue, marker|
      marker.lat venue.latitiude
      marker.lng venue.longitude
      marker.infowindow venue.name
    end
  end

end
