class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(query)
        Article.where("title like ?", "%#{query}%").or(Article.where("content like ?", "%#{query}%"))
    end
end
