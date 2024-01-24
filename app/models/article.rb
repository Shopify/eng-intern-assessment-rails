class Article < ApplicationRecord
    validates :title, :content, presence: true
    validates :author, :date, presence: true, allow_nil: true
  
    def self.search(query)
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
end
