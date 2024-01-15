class Article < ApplicationRecord
  # Checks for presence of an article's title and content
  validates :title, presence: true
  validates :content, presence: true

  # Class method to search articles based on title or content
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end