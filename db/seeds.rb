# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Custom function to generate paragraphs of various sizes (default paragraph size: 2)
def generate_random_paragraphs(random_num = 2)
  full_content = []
  random_num.times { full_content << Faker::Lorem.paragraph_by_chars(number: 700, supplemental: false) }

  return full_content.join("\n\n")
end

# Create specific first article
first_article = Article.new(
  title: "First Article",
  content: "Quo doloribus illum.",
  author: ["#{Faker::Name.male_first_name} #{Faker::Name.last_name}", "#{Faker::Name.female_first_name} #{Faker::Name.last_name}"].sample,
  date: Faker::Date.between(from: '2024-01-01', to: '2024-01-29')
)

puts "Created first article '#{first_article.title}' by #{first_article.author}!\n\n" if first_article.save!


# Modify integer to seed that many articles (default: 50)
50.times do
  article = Article.new(
    title: Faker::Lorem.words(number: 2..8, supplemental: true).join(" ").titleize,
    content: generate_random_paragraphs(Faker::Number.within(range: 2..6)),
    author: ["#{Faker::Name.male_first_name} #{Faker::Name.last_name}", "#{Faker::Name.female_first_name} #{Faker::Name.last_name}", nil].sample,
    date: Faker::Date.between(from: '2023-09-01', to: '2024-01-29')
  )

  puts "Created article '#{article.title}' by #{article.author}!" if article.save!
end


# Create specific last article
last_article = Article.create!(
  title: "Last Article",
  content: "Quo doloribus illum. Illum provident aut. Exercitationem beatae quos.",
  author: ["#{Faker::Name.male_first_name} #{Faker::Name.last_name}", "#{Faker::Name.female_first_name} #{Faker::Name.last_name}"].sample,
  date: Faker::Date.between(from: '2024-01-01', to: '2024-01-29')
)

puts "\nCreated last article '#{last_article.title}' by #{last_article.author}!\n"
