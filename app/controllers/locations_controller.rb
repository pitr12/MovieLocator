class LocationsController < ApplicationController
  def index
    @locations = Location.paginate(page: params[:page], :per_page => 20).order('name ASC')
  end

  def show
    @location = Location.find(params[:id])
    @movies = @location.movies
    @hash = Gmaps4rails.build_markers(@location) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow location.description
      marker.title location.name
      marker.json({ name: location.name })
    end
  end
end