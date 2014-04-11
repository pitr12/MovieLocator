include Sidekiq::Worker
require 'open-uri'
require 'nokogiri'

class MoviesWorker

  def perform
    (101..110).each do |id|
      html = open("http://www.imdb.com/title/tt#{id}/")

      page = Nokogiri::HTML(html)

      #get movie title and year
      head = page.css('h1').search('span')
      title =  head[0].text
      year =  head[1].text[1..-2]

      #get movie description
      description = page.css("p[itemprop='description']").text
      if(description.strip == "Add a Plot")
        description = " No description found"
      end
      description = description[1..-1]

      #if(Movie.last.present?)
      #  mid = Movie.last.id + 1
      #else
      #  mid = 1
      #end

      movie = Movie.create(title: title, description: description, year: year )

      #get movie locations
      html = open("http://www.imdb.com/title/tt#{id}/locations")
      page = Nokogiri::HTML(html)

      page.css("div[class='soda odd']").each do |div|
        name = div.search('dt')
        name = name.text.strip

        descr = div.search('dd')
        descr =  descr.text.strip

        location = Location.where(name: name)[0]

        if(!location.present?)
          location = Location.create(name: name, description: descr )
        end

        movie.localizations.create(location: location)

        name = ""
        descrp = ""
      end
    end
  end

end