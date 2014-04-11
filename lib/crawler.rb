require 'open-uri'
require 'nokogiri'


#(1..10).each do |id|
  html = open("http://www.imdb.com/title/tt0088247/")

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

  #get movie locations
  puts "Locations: "
  html = open("http://www.imdb.com/title/tt1/locations")
  page = Nokogiri::HTML(html)

  page.css("div[class='soda odd']").each do |div|
    name = div.search('dt')
    puts name.text.strip

    descr = div.search('dd')
    puts descr.text.strip
    puts " "
  end

#end

  #doc.search('.itemprop span').each do |title|
    #tds = tr.search('td')
    #puts title.text
    #case tds[0].text
    #when 'IČO:' then subject.ico = tds[0].text
    #when 'Obchodné meno:' then subject.name = tds[2].text
    #end
  #end
