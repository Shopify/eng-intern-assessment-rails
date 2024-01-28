class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # Implements search functionality within class Article.
  # Checks to see if input matches title, content, or author
  def self.search (query)
    key = "%#{query}%"
    @articles = Article.where("title LIKE ? or content LIKE ? or author LIKE?", key, key, key)
  end
end
