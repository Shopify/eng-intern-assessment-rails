class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    # query to return an article when the search term matches the content or title of an article. 
    def self.search(query)
        if query.present?
            where("title LIKE ? OR content LIKE ?", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%");
        else
            all
        end
    end
end
