class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: true
  validates :date, presence: true
  # Search by content and title
  def self.search(query)
    Article.where('content LIKE ?', "%#{query}%").or(Article.where('title LIKE ?', "%#{query}%"))
  end
end
