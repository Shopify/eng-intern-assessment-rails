# app/models/article.rb
class Article < ApplicationRecord

  # Validation for presence and length of title
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }

  # Validation for presence and length of content
  validates :content, presence: true, length: { minimum: 10, maximum: 1000 }

    def self.search(query)
      where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    end
    
  end
  