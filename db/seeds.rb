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

# Create some sample articles
Article.create(
  title: 'Introduction to Ruby on Rails',
  content: 'Ruby on Rails is a web application framework written in Ruby...',
  author: 'John Doe',
  date: Date.new(2024, 1, 26)
)

Article.create(
  title: 'Getting Started with ActiveRecord',
  content: 'ActiveRecord is the ORM (Object-Relational Mapping) layer in Rails...',
  author: 'Jane Smith',
  date: Date.new(2024, 1, 27)
)

Article.create(
  title: 'Ruby vs. Python for Web Development',
  content: 'A comparison of Ruby and Python for building web applications...',
  author: 'Bob Johnson',
  date: Date.new(2024, 1, 28)
)

