class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(query)
        where("title LIKE ? OR content Like ?", "%#{query}%", "%#{query}%")
    end
end
