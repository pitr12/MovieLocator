class MoviesController < ApplicationController

  def index
    if params[:query].present?
      @movies = Movie.search(params[:query], page: params[:page], order: {_score: :desc} )
    else
      @movies = (Movie.all.page params[:page]).order('title ASC')
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @locations = @movie.locations
  end

  def autocomplete
    @movies = Movie.search(params[:query], autocomplete: true, limit: 10)
    render json: @movies.map{|movie| {:name => movie.title, :year =>  movie.year, :img => movie.img} }
  end

  def check_url
    movies = Movie.where(:title => params[:query])
    if movies.size > 0
      respond_to do |format|
        format.html { render json: {:response => (movies.size == 1), :url => "/movies/#{movies[0].id}"}  }
        format.json { render json: {:response => (movies.size == 1), :url => "/movies/#{movies[0].id}"}  }
      end
    else
      respond_to do |format|
        format.html { render json: {:response => false, :url => ""} }
        format.json { render json: {:response => false, :url => ""} }

      end
    end
  end

  def update_data
    @location = Location.find(params[:id])
    @location.update_attributes(:latitude => params[:lat], :longitude => params[:lon])
  end

end
