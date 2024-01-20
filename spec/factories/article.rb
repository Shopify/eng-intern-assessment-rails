# spec/factories/articles.rb

FactoryBot.define do
  factory :article do
    # Define your article attributes here
    title { "Sample Article" }
    content { "Lorem ipsum dolor sit amet" }
  end
end
