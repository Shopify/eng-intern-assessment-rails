class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # Produces all articles that contain the query string in their title or content
  def self.search(query)
    like_query = "%#{query}%"
    Article
      .where("title LIKE ?", like_query)
      .or(where("content LIKE ?", like_query))
  end
end
