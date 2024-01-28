class Article < ApplicationRecord
    def self.search(query)
        # Search by title, content, author, date.
        where("title LIKE :query OR content LIKE :query OR author LIKE :query OR date LIKE :query", query: "%#{query}%")
    end
end
