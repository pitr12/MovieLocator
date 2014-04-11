require 'open-uri'
require 'nokogiri'


(1..20).each do |id|
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
end

  #doc.search('.itemprop span').each do |title|
    #tds = tr.search('td')
    #puts title.text
    #case tds[0].text
    #when 'IČO:' then subject.ico = tds[0].text
    #when 'Obchodné meno:' then subject.name = tds[2].text
    #end
  #end
