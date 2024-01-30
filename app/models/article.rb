class Article < ApplicationRecord
    # Validations
    validates :title, presence: true
    validates :content, presence: true
  
    # Search functionality
    def self.search(query)
      where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
  end
  