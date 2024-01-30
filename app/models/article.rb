class Article < ApplicationRecord
    #validations to ensure that the fields are present
    validates :title, presence: true
    validates :content, presence: true

    #method for searching articles based on a query
    def self.search(query)
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    end 
end
