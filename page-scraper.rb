require 'open-uri'
require 'nokogiri'
require 'pry'

page = Nokogiri::HTML(open('http://ruby005.students.flatironschool.com/'))
students = page.css('li.home-blog-post') #I think this is an array

student_scraped_data = []

#blurb, bio, edu, work, links

students.each do |student|
  profile_info = {}
  profile_info[:name] = student.css('div.blog-title div.big-comment h3 a').text
  profile_info[:tag_line] = student.css('div.blog-title p.home-blog-post-meta').text
  profile_info[:excerpt] = student.css('div.excerpt p').text
  link_to_page = student.css('div.blog-title div.big-comment h3 a').attribute('href').value
  student_page = Nokogiri::HTML(open('http://ruby005.students.flatironschool.com/' + link_to_page))
  profile_info[:blurb] = student_page.css('div.quote-div h3').text
  if bio_div = student_page.css('div.services').detect{|div| div.css('h3').text == "Biography"}
    profile_info[:bio] = bio_div.css('p').text
  elsif bio_div = student_page.css('div.services').detect{|div| div.css('h3').text == "About Me"}
    profile_info[:bio] = bio_div.css('p').text
  end
  education_div = student_page.css('div.services').detect{|div| div.css('h3').text == "Education"}
  
  profile_info[:edu] = education_div.css('li').map{|school|school.text}
  student_scraped_data << profile_info
end

p student_scraped_data[16][:bio]
p student_scraped_data[16][:edu]

#Nick Demarest - line breaks but one school
#Natalie Parellano - weird styling