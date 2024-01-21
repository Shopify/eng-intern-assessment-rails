module Mutations
  # Mutation for updating Articles given field arguments
  class UpdateArticle < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :content, String, required: false
    argument :author, String, required: false
    argument :date, GraphQL::Types::ISO8601Date, required: false

    field :article, Types::ArticleType, null: false
    field :errors, [String], null: false

    def resolve(id:, **attributes)
      article = Article.find(id)
      if article.update(attributes)
        { article: article, errors: [] }
      else
        { article: nil, errors: article.errors.full_messages }
      end
    end
  end
end
