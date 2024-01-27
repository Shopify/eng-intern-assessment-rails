class Article < ApplicationRecord
    # ensures that the title and content attribute is present 
    validates :title, presence: true   
    validates :content, presence: true

    # search functionality
    scope :search, ->(query) {
        where('title LIKE :query OR content LIKE :query OR author LIKE :query OR date LIKE :query', query: "%#{query}%")
    }
end
