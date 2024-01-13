class Article < ApplicationRecord
    def self.search(query)
        if query
            where('title LIKE ? OR content LIKE ?', "%#{query}", "%#{query}")
        else
            all
    end
end
