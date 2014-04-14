module MoviesHelper
  require 'net/http'

  # Returns the image for the given movie.
  def image_of(movie, msize)
    if(self.checkURI(movie))
    image_tag(movie.img, alt: movie.title, class: "movie_image", width: msize)
    else
      image_tag("/images/missing.jpg", alt: movie.title, class: "movie_image", width: msize)
    end
  end

  def checkURI(movie)
    if(movie.img.nil?)
      return false
    else return true
    end

    #uri = URI(movie.img)
    #request = Net::HTPP.new uri.host
    #response = request.request_head uri.path
    #return response.code.to_i == 200

  end
end
