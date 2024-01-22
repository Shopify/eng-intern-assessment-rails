class Article < ApplicationRecord
    def self.search(query)
        if query.present?
          where("title LIKE :query OR content LIKE :query OR author LIKE :query", query: "%#{query}%")
        else
          all
        end
    end

    # validate text fields
    validates :title, presence: true, uniqueness: true, length: { minimum: 5 }

    validates :content, presence: true, length: { minimum: 10 }
end
