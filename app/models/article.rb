class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    search_query = "%#{query}%"
    Article.where(["title LIKE ? OR content LIKE ?", search_query, search_query])
  end
end
