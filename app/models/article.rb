class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }

    def self.search(query)
        where("content like :query OR title like :query", query: "%#{query}%")
    end

end
