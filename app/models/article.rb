class Article < ApplicationRecord
    def self.search(search)
        if search
            # Returns articles with fields that are contained in the search params
            where('title LIKE ? OR content LIKE ? OR author LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
        else
            all
        end
    end    
end
