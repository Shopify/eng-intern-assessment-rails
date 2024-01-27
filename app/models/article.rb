class Article < ApplicationRecord
    def self.search(term)
        where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
    end
end
