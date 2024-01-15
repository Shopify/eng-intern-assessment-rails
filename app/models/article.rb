# Model class for Article
class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 1 }

  # Search for articles where the title or content matches the query
  def self.search(query)
    Article.where('title LIKE ?', "%#{query}%")
           .or(Article.where('content LIKE ?', "%#{query}%"))
           .distinct
  end
end
