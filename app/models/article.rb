class Article < ApplicationRecord
    # Validate that the article contains at least a title and content
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }

    # self.search returns an ActiveRecord::Relation where either the title or the content contain the query
    # If the query is not present, we simply return all articles.
    def self.search(query)
        if query.present?
            where("content LIKE :query OR title LIKE :query", query: "%#{sanitize_sql_like(query)}%")
        else
            self.all
        end
    end

end
