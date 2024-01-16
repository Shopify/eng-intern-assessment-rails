# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Create Article
    field :create_article, mutation: Mutations::CreateArticle

    # Update/Edit Article
    field :update_article, mutation: Mutations::UpdateArticle

    # Delete Article
    field :delete_article, mutation: Mutations::DeleteArticle
  end
end
