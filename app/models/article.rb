class Article < ApplicationRecord
    # Model validations
    validates :title, presence: true
    # checks if there is content
    validates :content, presence: true, length: { minimum: 10 }
  
    # Model associations
    # Search functionality
    def self.search(query)
      where("lower(title) LIKE ? OR lower(content) LIKE ?", "%#{query.downcase}%", "%#{query.downcase}%")
    end
  
end
