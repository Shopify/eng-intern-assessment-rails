class Article < ApplicationRecord

    attribute :content, :string
    attribute :author, :string
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }

    def self.search(query)
        where("title LIKE ? OR author LIKE ? or content LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    end
end
