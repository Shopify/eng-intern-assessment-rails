class Article < ApplicationRecord
    # Only the title and content fields are required
    validates :title, presence: true
    validates :content, presence: true
    
    # Search function
    def self.search(search)
        if search
            where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
        else
            all
        end
    end
end
