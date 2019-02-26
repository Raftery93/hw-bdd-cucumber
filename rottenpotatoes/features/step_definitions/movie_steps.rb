# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #movie = Movie.new
    #Movie.add(movie)
    Movie.create!(movie) #Add movie to table
  end
  @movies = Movie.all 
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
################################
When /^I check the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |rating|
      step %Q{I check "ratings_#{rating}"}
  end
end
When /^I uncheck the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |rating|
      step %Q{I uncheck "ratings_#{rating}"}
  end
end
Then /^I should see the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |text|  
     # byebug
     step %Q{I should see "#{text}"}
  end
end
Then /^I should not see the following ratings: (.*)/ do |rating_list|
  rating_list.split(", ").each do |text|
    (page.body=~/\Atext\z/) == nil 
  end
end
####################################

When(/^I check all movies$/) do
  @movies.pluck(:rating).uniq.each do |rating| 
    step %Q{I check "ratings_#{rating}"}
  end
end
 
Then /^I should see all the movies/ do
  @movies.each do |movie|
    step %Q{I should see "#{movie.title}"}
  end
end
