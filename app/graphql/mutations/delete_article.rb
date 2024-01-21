module Mutations
  # Mutation for deleting Articles given id
  class DeleteArticle < BaseMutation
    argument :id, ID, required: true

    field :message, String, null: false

    def resolve(id:)
      article = Article.find(id)
      article.destroy
      { message: 'Article successfully deleted' }
    end
  end
end
