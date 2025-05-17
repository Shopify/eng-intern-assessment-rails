class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # perform case-insentitive search on title or content of articles
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
