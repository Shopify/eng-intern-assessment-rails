# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

sample_article = Article.create!(
  title: "Sample Article",
  content: "Lorem ipsum dolor sit amet.",
  author: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
  date: Faker::Date.between(from: '2024-01-01', to: '2024-01-29')
)

puts "Created sample article '#{sample_article.title}' by #{sample_article.author}!\n\n"

25.times do
  article = Article.create!(
    title: Faker::Lorem.words(number: 2..8, supplemental: true).join(" ").titleize,
    content: Faker::Lorem.paragraphs(number: 2..6).join("\n\n"),
    author: ["#{Faker::Name.first_name} #{Faker::Name.last_name}", nil].sample,
    date: [Faker::Date.between(from: '2023-09-01', to: '2024-01-29'), nil].sample
  )

  puts "Created article '#{article.title}' by #{article.author}!"
end

another_article = Article.create!(
  title: "Another Article",
  content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  author: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
  date: Faker::Date.between(from: '2024-01-01', to: '2024-01-29')
)

puts "\nCreated another article '#{another_article.title}' by #{another_article.author}!\n"
