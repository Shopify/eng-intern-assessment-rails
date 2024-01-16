module Types
  class ArticleType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :content, String, null: true
    field :author, String, null: true
    field :date, GraphQL::Types::ISO8601Date, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user_id, String, null: true
    field :user, Types::UserType, null: true

    def user
      object.user
    end
  end
end
