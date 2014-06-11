require 'open-uri'
require 'nokogiri'

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
    
  student_scraped_data << profile_info
end

student_scraped_data