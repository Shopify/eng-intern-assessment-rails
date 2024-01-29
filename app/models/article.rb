class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(query)
        where("title LIKE :query OR content LIKE :query OR author LIKE :query OR date LIKE :query", query: "%#{query}%")
      end
end