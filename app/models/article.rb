class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }

    def self.search(query)
        where("title LIKE ? or content LIKE ?", "%#{query}%", "%#{query}%")
    end
end
