class Article < ApplicationRecord
  # Validates the fields to ensure valid inputs
  validates :title, presence: true
  validates :content, presence: true

  # Performs query searches using a query term against the title and content
  def self.search(term)
    # Checks if the query term is present, or returns all articles if not
    if term.present?
      # OPTIMIZE: Full-text search would be more performant for large tables
      where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
    else
      all
    end
  end
end
