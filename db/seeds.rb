# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

articles = [
    { title: "Understanding Ruby on Rails", content: "This article will delve into the Ruby on Rails framework...", author: "Johnson Duong", date: "2022-01-01" },
    { title: "The Future of JavaScript", content: "JavaScript has evolved significantly over the years...", author: "Jane Smith", date: "2022-01-02" },
    { title: "Introduction to Machine Learning", content: "Machine learning is a subset of artificial intelligence..." },
    { title: "Best Practices for RESTful APIs", content: "When designing a RESTful API, there are several best practices to follow...", author: "Jane Smith", date: "2022-01-04" },
    { title: "Exploring the Python Standard Library", content: "The Python Standard Library provides a wealth of modules and functions...", author: "John Doe", date: "2022-01-05" }
]

articles.each do |article|
    Article.find_or_create_by!(title: article[:title], content: article[:content], author: article[:author], date: article[:date])
end