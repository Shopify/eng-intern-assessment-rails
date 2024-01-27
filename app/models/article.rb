class Article < ApplicationRecord
    # ensures that the title and content attribute is present 
    validates :title, presence: true   
    validates :content, presence: true

    # search functionality
    scope :search, ->(query) { where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%") }
end
