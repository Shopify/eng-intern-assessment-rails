class Article < ApplicationRecord
  # Ensure that articles have a title and content.
  validates :title, presence: true
  validates :content, presence: true

  # Search for articles by title or content.
  def self.search(term)
    # If the search term is present, return articles that match the term.
    if term.present?
      where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
    # Otherwise, return all articles.
    else
      all
    end
  end
end
