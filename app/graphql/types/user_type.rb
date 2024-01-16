module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :provider, String, null: true
    field :uid, String, null: false
    field :name, String, null: true
    field :email, String, null: true
    field :image, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :articles, [Types::ArticleType], null: false

    def articles
      # Fetch articles belonging to the user
      object.articles
    end
  end
end
