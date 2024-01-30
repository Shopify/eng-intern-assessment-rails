class Article < ApplicationRecord
    # Search for an article by title, content, or author
    def self.search(search)
        if search
            where([
                "title LIKE ? OR content LIKE ? OR author LIKE ?", 
                "%#{search}%", 
                "%#{search}%", 
                "%#{search}%"
            ])
        else
            all
        end
    end
end
