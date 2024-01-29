class Article < ApplicationRecord
    # Ensure that every article includes title and content
    validates :title, presence: true
    validates :content, presence: true
    validates :author, presence: false
    validates :date, presence: false
  
    # Class method for searching articles based on query params
    def self.search(query)
      if query.present?
        # Use SQLite-compatible case-insensitive search for title and content
        where('LOWER(title) LIKE LOWER(:query) OR LOWER(content) LIKE LOWER(:query)', query: "%#{query}%")
      else
        # Otherwise if there are no query params we can return all the articles
        all
      end
    end
  end
