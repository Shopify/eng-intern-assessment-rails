class Article < ApplicationRecord
    # Ensures that articles must have a non-empty title and content
    validates :title, presence: true
    validates :content, presence: true

    # This class method searches for articles based on the title or its content
    def self.search(query)
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
end
