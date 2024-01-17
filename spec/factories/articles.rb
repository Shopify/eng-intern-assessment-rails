# spec/factories/articles.rb

FactoryBot.define do
  factory :article, class: Article do
    title { "Sample Article" }
    content { "Lorem ipsum dolor sit amet" }
  end
end unless FactoryBot.factories.registered?(:article)
