class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # Returns articles which match the query
  def self.search(query)
    if query.present?
      key = "%#{query}%"
      @articles = Article.where("lower(title) LIKE ? or lower(content) LIKE ? or lower(author) LIKE?", key, key, key)
    else
      @articles = Article.all
    end
  end
end