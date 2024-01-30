class Article < ApplicationRecord
    # Validations
    validates :title, presence: true
    validates :content, presence: true
    # validates :author, presence: true


    # search
    def self.search(query)
      where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
  end