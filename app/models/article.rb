class Article < ApplicationRecord
  # Checks title and content is present.
  validates :title, :content, presence: true

  # Search functionally only searches title and content, not metadata
  # Returns all articles if no query specified
  def self.search(query)
    if query.present?
      #Add case-insensitivity to query
      where("LOWER(title) LIKE :query OR LOWER(content) LIKE :query", query: "%#{query.downcase}%")
    else
      all
    end
  end
end
