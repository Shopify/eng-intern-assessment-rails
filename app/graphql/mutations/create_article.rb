module Mutations
  class CreateArticle < BaseMutation
    argument :title, String, required: true
    argument :content, String, required: true
    argument :author, String, required: true
    argument :date, GraphQL::Types::ISO8601Date, required: false
    argument :categories, [String], required: false

    field :article, Types::ArticleType, null: true
    field :errors, [String], null: false

    def resolve(title:, content:, author:, date: nil, categories: [])
      article = Article.new(
        title: title,
        content: content,
        author: author,
        date: date,
        categories: categories
      )

      if article.save
        {
          article: article,
          errors: []
        }
      else
        {
          article: nil,
          errors: article.errors.full_messages
        }
      end
    end
  end
end 