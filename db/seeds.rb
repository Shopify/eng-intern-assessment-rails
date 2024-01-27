# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Seed data for Articles
# Ensures the existence of a few articles for demonstration and testing purposes

# Example articles data
articles_data = [
  { title: "The History of Ruby", content: "Ruby is a dynamic, open source programming language...",
  author: "Yukihiro Matsumoto", date: Date.new(2023, 1, 1) },
  { title: "Understanding MVC", content: "The Model-View-Controller (MVC) framework is...",
  author: "John Doe", date: Date.new(2023, 1, 2) },
  # ... add more articles as needed ...
]

# Creating or updating articles
articles_data.each do |article_data|
  article = Article.find_or_initialize_by(title: article_data[:title])
  article.update!(article_data)
end
