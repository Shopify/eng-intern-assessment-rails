# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Article.create(title: "First Article", content: "This is the first article", author: "John Doe", date: "2021-01-01")
Article.create(title: "Second Article", content: "This is the second article", author: "Dane Koe", date: "2021-01-02")
Article.create(title: "Third Article", content: "This is the third article", author: "Base Roe", date: "2021-01-03")
Article.create(title: "Fourth Article", content: "This is the fourth article", author: "Jane Doe", date: "2021-01-04")
Article.create(title: "Fifth Article", content: "This is the fifth article", author: "Ohn Doej", date: "2021-01-05")
Article.create(title: "Sixth Article", content: "This is the sixth article", author: "Hn Doejo", date: "2021-01-06")
