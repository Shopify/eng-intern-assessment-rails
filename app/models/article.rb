class Article < ApplicationRecord
    def self.search(query)
      Article.where('content LIKE ?', "%#{query}%").or(Article.where('title LIKE ?', "%#{query}%"))
    end
end
