class Article < ApplicationRecord
  # Validates that the title and content must be present as well as content having a minimum of 10 characters for an article to be valid
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  # Class method 'search' used to search for articles based on a query string
  # It searches within the title, content, author, and date fields
  def self.search(query)
    if query
      where('title LIKE ? OR content LIKE ? OR author LIKE ? OR date LIKE ?',
            "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
    else
      # If no query is provided, it returns all articles
      all
    end
  end
end
