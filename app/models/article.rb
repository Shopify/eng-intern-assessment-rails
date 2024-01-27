class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }

       # search query for title or content matching query
    def self.search(query)
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
  end
  