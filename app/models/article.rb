class Article < ApplicationRecord
    def self.search(query_string)
        return Article.where(
            "articles.title LIKE :query OR "\
            "articles.content LIKE :query", 
            {query: "%#{query_string}%"}
        )
    end
end
