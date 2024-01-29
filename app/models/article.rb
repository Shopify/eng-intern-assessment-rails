# app/models/article.rb
class Article < ApplicationRecord

    def self.search(query)
      where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    end
    
  end
  