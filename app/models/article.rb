class Article < ApplicationRecord
  # enture that the title and content fields are always filled in
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  # search method
  # returns all articles that contain the search query in either the title or content fields
  def self.search(query)
    # sanitize_sql_like prevents SQL injection attacks
    Article.sanitize_sql_like(query)
    where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
  end
end
