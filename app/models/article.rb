class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }
    validates :author, presence: true
    validates :date, presence: true

  #   scope :search, ->(query) {
  #   where("title LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%")
  # }

    def self.search(query)
      where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
  end
  