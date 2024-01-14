class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5, maximum: 100 }
    validates :content, presence: true, length: { minimum: 10, maximum: 1000 }

    def self.search(query)
        Article.where("title like ?", "%#{query}%").or(Article.where("content like ?", "%#{query}%"))
    end
end
