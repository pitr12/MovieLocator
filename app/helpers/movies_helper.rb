module MoviesHelper
  # Returns the image for the given movie.
  def image_of(movie, msize)
    image_name = "movie_#{movie.id}.jpg"
    if FileTest.exist?("#{Rails.root}/public/images/#{image_name}")
      image_check = image_tag("/images/#{image_name}", alt: movie.title, class: "movie_image", width: msize)
    else
      image_check = image_tag("/images/missing.jpg", alt: movie.title, class: "movie_image", width: msize)
    end
  end
end
