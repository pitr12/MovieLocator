include Sidekiq::Worker
require 'open-uri'
require 'nokogiri'

class MoviesWorker

  def perform(id)
      html = open("http://www.imdb.com/title/tt#{id}/")

      page = Nokogiri::HTML(html)

      #get movie title and year
      title = page.css('h1 span[itemprop=name]')[-1].text
      if(title.include?("(original title)"))
        title.sub! '(original title)', ''
        title = title.strip[1..-2]
      end

      year = page.css('h1 span.nobr')[0].text[1..-2]

      #get movie description
      description = page.css("p[itemprop='description']").text
      if(description.strip == "Add a Plot")
        description = " No description found"
      end
      description = description[1..-1]

      div_image = page.css("div.image")
      image = div_image.search('img')
      if (image.empty?)
        image = "Missing"
      else
        image = image[0]["src"]
      end

      movie = Movie.new(title: title, description: description, year: year , img: image)
      if(movie.save)

        #get movie locations
        html = open("http://www.imdb.com/title/tt#{id}/locations")
        page = Nokogiri::HTML(html)

        page.css("div.soda").each do |div|
          name = div.search('dt')
          name = name.text.strip

          descr = div.search('dd')
          descr = descr.text.strip
          if(descr == "")
            descr = "No description available"
          else
            descr =  descr[1..-2]
          end


            location = Location.where(name: name)[0]
            if(!location.nil?)
              movie.localizations.create(location: location)
            else
              location = Location.new(name: name, description: descr )
              if(location.save)
                movie.localizations.create(location: location)
              end
            end
        end
      end
  end
end