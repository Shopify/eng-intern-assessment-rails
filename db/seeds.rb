# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create some mock data by default
preset_articles = [
  {
    title: 'Interning at Shopify',
    content: 'At Shopify we created a lot of cool things!',
    date: Date.today,
    author: 'Adam Chen'
  },
  {
    title: 'School at the University of Waterloo',
    content: 'We learn a lot of cool topics!',
    date: Date.today,
    author: 'Adam Chen'
  }
]

preset_articles.each do |article|
  Article.find_or_create_by!(title: article[:title],
                             content: article[:content],
                             date: article[:date],
                             author: article[:author],
  )
end