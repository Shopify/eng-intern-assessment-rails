class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    
    # search the specified article from the database
    def self.search(query)
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
end
