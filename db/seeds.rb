# This file ensures the existence of records required to run the application in every environment (production,
# development, test). The code here is idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

Article.find_or_create_by!(
  title: 'First Article',
  content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  author: 'John Doe',
  date: Date.today
)

Article.find_or_create_by!(
  title: 'Second Article',
  content: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  author: 'Jane Smith',
  date: Date.yesterday
)