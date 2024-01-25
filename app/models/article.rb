class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }

    def self.search(query)
        Article.where('title LIKE ?', "%#{query}%").or(Article.where('content LIKE ?', "%#{query}%"))
    end
end