# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    # Query for getting all Articles
    field :articles, [Types::ArticleType], null: false, description: 'Fetches a list of articles'
    def articles
      Article.all
    end

    # Query for getting all Users
    field :users, [Types::UserType], null: false, description: 'Fetches a list of users'
    def users
      User.all
    end

    # Query for searching Articles
    field :search_articles, [Types::ArticleType], null: false, description: 'Fetches articles based on search query' do
      argument :query, String, required: false
    end
    def search_articles(query: nil)
      Article.search(query)
    end
  end
end
