class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(search_query)
        # Sanitize search_query to prevent injections from occurring
        Article.sanitize_sql_like(search_query)

        where("title LIKE ? OR content LIKE ?", "%#{search_query}%", "%#{search_query}%")
    end
end
