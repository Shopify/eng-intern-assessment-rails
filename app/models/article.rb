class Article < ApplicationRecord
  # Ensuring these values are present and not blank
  validates :title, presence: true
  validates :content, presence: true

  # Custom search method for articles
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
