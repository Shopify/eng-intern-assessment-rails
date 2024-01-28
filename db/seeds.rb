# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  { title: "The History of Computing", content: "An in-depth look at the history of computing...", author: "Alex Smith", date: Date.new(2020,1,1) },
  { title: "Exploring the Ocean Depths", content: "Discover the mysteries of the deep ocean...", author: "Marie Johnson", date: Date.new(2020,6,15) },
  { title: "Space Exploration: Past and Present", content: "A journey through the history of space exploration...", author: "Chris Wong", date: Date.new(2021,3,10) }
].each do |article_attrs|
  Article.find_or_create_by!(title: article_attrs[:title]) do |article|
    article.content = article_attrs[:content]
    article.author = article_attrs[:author]
    article.date = article_attrs[:date]
  end
end