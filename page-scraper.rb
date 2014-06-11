require 'open-uri'
require 'nokogiri'

page = Nokogiri::HTML(open('http://ruby005.students.flatironschool.com/'))
students = page.css('li.home-blog-post') #I think this is an array

student_scraped_data = []

students.each do |student|
  profile_info = {}
  profile_info[:name] = student.css('div.blog-title div.big-comment h3 a').text
  profile_info[:tagline] = student.css('div.blog-title p.home-blog-post-meta').text
  profile_info[:excerpt] = student.css('div.excerpt p').text
  student_scraped_data << profile_info
end

p student_scraped_data