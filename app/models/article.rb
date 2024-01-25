class Article < ApplicationRecord
    # Validates title and content.
    validates :title, :content, presence: true
    # Optionally validates author and date.
    validates :author, :date, presence: true, allow_nil: true
    
    # Search functionality by filtering though articles title and content.
    def self.search(query)
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
end
