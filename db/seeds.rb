require 'faker'

# Create the first article
first_article = Article.create(
  title: "Secret Sauce: Why I'm the Software Intern You Didn't Know You Needed 🚀",
  content: 'He demonstrated outstanding performance as well as a level of curiosity for continual learning and growth as a software engineer. He thrived in challenges. He consistently delivered high-quality work, sought help when necessary, and adjusted to feedback. Additionally, he excelled in collaboration, communication, and adapting to changes 🚀.',
  author: 'Hung Nguyen',
  date: Date.today
)

(rand(30..40)).times do
  Article.create(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph,
    author: Faker::Name.name,
    date: Faker::Date.between(from: 1.year.ago, to: Date.today)
  )
end

puts 'Seed data created successfully.'
