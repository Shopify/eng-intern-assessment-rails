require 'date'

module Mutations
  # Mutation for creating Articles
  class CreateArticle < BaseMutation
    argument :title, String, required: true
    argument :content, String, required: true
    argument :author, String, required: true
    argument :date, GraphQL::Types::ISO8601Date, required: false
    argument :user_id, String, required: true

    field :article, Types::ArticleType, null: false
    field :errors, [String], null: false

    def resolve(title:, content:, author:, date:, user_id:)
      article = Article.new(title: title, content: content, author: author, date: date || Date.today, user_id: user_id)
      if article.save
        { article: article, errors: [] }
      else
        { article: nil, errors: article.errors.full_messages }
      end
    end
  end
end
