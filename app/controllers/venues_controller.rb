class VenuesController < ApplicationController
# This controller deals with putting VENUES on the MAP
  def index
    @venues = Venue.all
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

  # I don't know where to put this so it lives here for now
  # It's a method for generating the on-click info on the map markers
  def gmaps4rails_infowindow(venue)
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
      "
  end

end
