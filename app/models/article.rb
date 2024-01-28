class Article < ApplicationRecord

def self.search(query)
    if query
        self.where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    else
        Article.all
    end
end
end