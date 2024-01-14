class Article < ApplicationRecord
    def self.search(query)
        where('content LIKE :query OR title LIKE :query', query: "%#{query}%")
    end
end
