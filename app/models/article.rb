class Article < ApplicationRecord
    # Search for articles by title or body or author
    def self.search(search)
        if search
            where(["title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%"])
        else
            all
        end
    end
end
