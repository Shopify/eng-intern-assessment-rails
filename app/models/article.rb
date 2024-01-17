class Article < ApplicationRecord
    #Validate that the required fields: Title and Content, are always supplied to the Model
    validates :title, presence: true
    validates :content, presence: true

    def self.search(query)
        if query
          where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
        else
          all
        end
      end
end
