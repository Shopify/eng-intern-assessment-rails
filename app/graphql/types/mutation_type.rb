module Types
  class MutationType < Types::BaseObject
    field :create_article, mutation: Mutations::CreateArticle
  end
end 