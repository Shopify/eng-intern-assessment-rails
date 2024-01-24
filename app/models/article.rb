class Article < ApplicationRecord
    def self.search(query)
        where("title LIKE :query OR content LIKE :query", query: "%#{query}%")
    end
end
