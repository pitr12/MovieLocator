module MoviesHelper
  # Returns the image for the given movie.
  def image_of(movie, msize)
    image_name = "movie_#{movie.id}.jpg"
    image_tag(image_name, alt: movie.title, class: "movie_image", width: msize)
  end
end
