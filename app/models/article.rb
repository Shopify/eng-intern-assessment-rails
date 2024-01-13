class Article < ApplicationRecord
    # Return article which matches some words in title or content, else return everything
    def self.search(query)
        if query
            where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
        else
            all
        end
    end
end