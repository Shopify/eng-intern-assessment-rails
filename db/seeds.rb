# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Sample articles data
sample_articles = [
  { title: 'Article 1', content: 'Content for article 1.', author: 'Rodrigo', date: Date.today },
  { title: 'Article 2', content: 'Some other content forr article 2', author: 'David', date: Date.today - 1.day },
]

# Create or find articles
sample_articles.each do |article_attrs|
  Article.find_or_create_by!(title: article_attrs[:title]) do |article|
    article.content = article_attrs[:content]
    article.author = article_attrs[:author]
    article.date = article_attrs[:date]
  end
end