# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Populate database with sample content
Article.create(
  title: 'Introduction to Ruby on Rails',
  content: 'Enjoying Rails in a way that I never imagined I would',
  author: 'Daniel Heinemann',
  date: Date.new(2024, 1, 27)
)

Article.create(
  title: 'Rust vs Ruby/RoR performances for API calls',
  content: 'It goes x12 faster using a x10 cheaper Heroku dyno compared to the Ruby version. Fetching about 10MB of (streamed) JSON (taken from pgsql objects) goes from 10.8sec to 0.9sec. And the server process currently takes 4MB memory (Ruby/RoR: > 2048MB but it does many other things yet).',
  author: 'Rob Foss',
  date: Date.new(2024, 1, 26)
)

Article.create(
  title: 'The tie between Ruby and Rust',
  content: 'Integrate Ruby with your Rust application. Or integrate Rust with your Ruby application. This project allows you to do either with relative ease.',
  author: 'Earl Grey',
  date: Date.new(2024, 1, 22)
)