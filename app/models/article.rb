class Article < ApplicationRecord 

    validates :title, presence:true
    validates :content, presence:true
    
    def self.search(query)
        sanitized_query = sanitize_sql_like(query)
        where("title LIKE ? or content LIKE ? or author LIKE ?",
            "%#{sanitized_query}%",
            "%#{sanitized_query}%",
            "%#{sanitized_query}%"
        )

    end
end
