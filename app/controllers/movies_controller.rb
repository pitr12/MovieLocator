class MoviesController < ApplicationController
  def index
    @movies = Movie.paginate(page: params[:page], :per_page => 20).order('title ASC')
  end

  def show
    @movie = Movie.find(params[:id])
  end

end
