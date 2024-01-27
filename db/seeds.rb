# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Article.delete_all

user = User.find_or_create_by!(email: 'user@example.com') do |u|
  u.password = 'password'
  u.password_confirmation = 'password'
  u.name = 'bigtester'
  # Set other required fields by your User model validations
end

# Create articles
Article.create(title: 'First Article', content: 'This is the first article', user: user)
Article.create(title: 'Second Article', content: 'This is the second article', user: user)


# ... add as many articles as you want

puts 'Articles have been seeded.'
