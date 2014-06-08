class LocationsController < ApplicationController
  def index
    if params[:query].present?
      @locations = Location.search(params[:query], page: params[:page], order: {_score: :desc} )
    else
      @locations = (Location.all.page params[:page]).order('name ASC')
    end
  end

  def show
    @location = Location.find(params[:id])
    @movies = @location.movies.paginate(page: params[:page], :per_page => 5).order('title ASC')
    @hash = Gmaps4rails.build_markers(@location) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow location.description
      marker.title location.name
      marker.json({ name: location.name })
    end
  end

  def autocomplete
    @locations = Location.search(params[:query], autocomplete: true, limit: 10)
    render json: @locations.map{|location| {:name => location.name} }
  end

  def check_url
    locations = Loction.where(:name => params[:query])
    if locations.size > 0
      respond_to do |format|
        format.html { render json: {:response => (locations.size == 1), :url => "/locations/#{locations[0].id}"}  }
        format.json { render json: {:response => (locations.size == 1), :url => "/locations/#{locations[0].id}"}  }
      end
    else
      respond_to do |format|
        format.html { render json: {:response => false, :url => ""} }
        format.json { render json: {:response => false, :url => ""} }

      end
    end
  end
end