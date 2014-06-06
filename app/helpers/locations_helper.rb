module LocationsHelper
  def location_image_of(movie, msize)
    if(self.checkURI(movie))
      image_tag(movie.img, alt: movie.title, class: "small_image", width: msize)
    else
      image_tag("/images/missing.jpg", alt: movie.title, class: "small_image", width: msize)
    end
  end
end