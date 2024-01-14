class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :author, presence: true
    validates :date, presence: true
    def self.search(query)
        where("title LIKE ? OR content LIKE ? OR author LIKE ? OR date LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
    end
end
