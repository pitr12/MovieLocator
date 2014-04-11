include Sidekiq::Worker
require 'open-uri'
require 'nokogiri'

class MoviesWorker

  def perform(id)
    (6..10).each do |id|
      html = open("http://www.imdb.com/title/tt#{id}/")

      page = Nokogiri::HTML(html)

      #get movie title and year
      head = page.css('h1').search('span')
      title =  head[0].text
      year =  head[1].text[1..-2]
      puts "Title: " + title
      puts "Year: " + year

      #get movie description
      description = page.css("p[itemprop='description']").text
      if(description.strip == "Add a Plot")
        description = " No description found"
      end
      puts "Description: " + description[1..-1]
      description = description[1..-1]

      id = Movie.last.id + 1
      Movie.create(title: title, description: description, year: year, id: id )

    end
  end

end