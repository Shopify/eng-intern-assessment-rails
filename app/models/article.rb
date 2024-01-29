class Article < ApplicationRecord
    # Validations: title, content
    validates :title, presence: true
    validates :content, presence: true
    
    # Method to perform search
    def self.search(search_text)
        if search_text
            where('title LIKE ? OR content LIKE ?', "%#{search_text}%", "%#{search_text}%")
        else 
            all
        end
    end
end
