class Article < ApplicationRecord

    validates :title, :content, presence: true
 
    # Returns articles that match the query
    def self.search(query)
        where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    end
 end
 