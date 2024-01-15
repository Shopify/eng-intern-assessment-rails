class Article < ApplicationRecord
  # title and content fields cannot be null
  validates :title, presence: true
  validates :content, presence: true

  # search method based on title and content of articles
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
