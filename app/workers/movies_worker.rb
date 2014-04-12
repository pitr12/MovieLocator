include Sidekiq::Worker
require 'open-uri'
require 'nokogiri'

class MoviesWorker

  def perform
    (1..100).each do |id|
      html = open("http://www.imdb.com/title/tt#{id}/")

      page = Nokogiri::HTML(html)

      #get movie title and year
      head = page.css('h1').search('span')
      title =  head[0].text
      year =  head[1].text[1..-2]
      if(head.size == 3)
        title =  head[2].text.split('"')[1]
      end
      puts "Title: " + title

      #get movie description
      description = page.css("p[itemprop='description']").text
      if(description.strip == "Add a Plot")
        description = " No description found"
      end
      description = description[1..-1]

      movie = Movie.create(title: title, description: description, year: year )

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
        puts "Location: " + name
        puts "Description: " + descr

        location = Location.where(name: name)[0]

        if(!location.present?)
          location = Location.create(name: name, description: descr )
        end

        movie.localizations.create(location: location)
      end

    end
  end

end