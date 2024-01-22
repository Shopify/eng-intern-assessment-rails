class Article < ApplicationRecord
    def self.search(query)
        if query.present?
          where("title LIKE :query OR content LIKE :query OR author LIKE :query", query: "%#{query}%")
        else
          all
        end
    end


    # validate text fields
    validates :title, presence: true
    validates :title, uniqueness: true
    validates :title, length: { minimum: 5 }

    validates :content, length: { minimum: 10 }
    validates :content, presence: true
    
    validates :author, presence: true
    validates :date, presence: true

end
