class MoviesController < ApplicationController

  def index
    if params[:query].present?
      @movies = Movie.search(params[:query], page: params[:page])
    else
      @movies = Movie.all.page params[:page]
    end


    #@movies = Movie.paginate(page: params[:page], :per_page => 20).order('title ASC')
  end

  def show
    @movie = Movie.find(params[:id])
    @locations = @movie.locations
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow location.description
      marker.title location.name
      marker.json({ name: location.name })
    end
  end

end
