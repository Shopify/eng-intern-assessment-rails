class Article < ApplicationRecord
    # Validations for strong parameters - requires title and content to be present
    validates :title, presence: true
    validates :content, presence: true


    # Search function - looks for query in title and content
    def self.search(query)
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
end
