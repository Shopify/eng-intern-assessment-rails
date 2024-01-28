Article.delete_all
User.delete_all

# Create user
user = User.find_or_create_by!(email: 'user@example.com') do |u|
  u.password = 'password'
  u.password_confirmation = 'password'
  u.name = 'TestUser1'
end

# Create articles
Article.create(title: 'A Shopify interns insight to mentorship', content: 'I completed my internship at Shopify in the Winter 2021 term. This was my first time working at Shopify...', user: user)
Article.create(title: 'How Shopify Writes Scalable Go Services', content: 'Let’s set the scene a bit. Go is one of the fastest growing programming languages...', user: user)
Article.create(title: 'Ruby’s Top 100 Packages Dependencies', content: 'In June of this year, RubyGems, the main repository for Ruby packages (gems)...', user: user)

puts 'DB has been seeded.'
