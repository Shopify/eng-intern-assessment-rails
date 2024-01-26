class Article < ApplicationRecord
    def self.search(search)
        if search
            where(["title LIKE ? OR content LIKE ? or author LIKE ?","%#{search}%", "%#{search}%", "%#{search}%"])
        else
            all
        end
    end
end
