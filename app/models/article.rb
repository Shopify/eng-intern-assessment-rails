class Article < ApplicationRecord

    # Validate that only valid article with title and content saved into the database.
    validates :title, presence: true
    validates :content, presence: true
  
    # Search articles by title or content
    def self.search(query)
        query = query.downcase
        # Specify each column could be part of the search
        where("LOWER(title) LIKE :query OR LOWER(content) LIKE :query OR LOWER(author) LIKE :query", query: "%#{query}%")
    end
  end
  