class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # Class method for searching articles based on title or content.
  # This method performs a case-insensitive search using SQL's LIKE operator.
  # It returns articles that have a title or content containing the specified query.
  def self.search(query)
    where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
  end
end
