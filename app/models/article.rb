class Article < ApplicationRecord
  # Set base requirements for an article because an empty/redundant article would be obselete.
  validates :title, presence: true
  validates :content, presence: true, length: {minimum: 10}
  
  # Enable searching through the database with a query that matches either with the article title or content.
  def self.search(search)
    where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
  end
end
