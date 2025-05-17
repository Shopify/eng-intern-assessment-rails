class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

def self.search(query)
    if query
        self.where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    else
        Article.all
    end
end
end