require 'faker'

5.times do
    Article.create(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
      author: Faker::Name.name,
      date: Faker::Date.between(from: 1.year.ago, to: Date.today)
    )
  end