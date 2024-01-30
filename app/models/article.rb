class Article < ApplicationRecord
  # Validation: Title and content must be present for an article
  validates :title, presence: true
  validates :content, presence: true

  # Class method for searching articles based on a query
  # Matching titles or content containing the query string are returned
  def self.search(query)
    where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
  end
end
