# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Populate the database with sample articles
Article.create(
  title: 'Shopify',
  content: 'Shopify Inc. is a Canadian multinational e-commerce company headquartered in Ottawa, Ontario. Shopify is the name of its proprietary e-commerce platform for online stores and retail point-of-sale systems.',
  author: 'Tobias Lütke',
  date: Date.new(2006, 6, 15)
)

Article.create(
  title: 'Google',
  content: 'Google LLC is an American multinational technology company focusing on artificial intelligence, online advertising, search engine technology, cloud computing, computer software, quantum computing, e-commerce, and consumer electronics.',
  author: 'Bill Gates',
  date: Date.new(1998, 9, 4)
)

Article.create(
  title: 'Apple',
  content: 'Apple Inc. is an American multinational technology company headquartered in Cupertino, California, in Silicon Valley. It designs, develops, and sells consumer electronics, computer software, and online services.',
  author: 'Steve Jobs',
  date: Date.new(1976, 4, 1)
)
