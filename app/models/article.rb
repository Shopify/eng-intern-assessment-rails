class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    if query
      # Search by title or content with the user-entered value
      Article.where(["title LIKE ? OR content LIKE ?", "%#{query}%",
                     "%#{query}%"]).order("date DESC ")
    else
      # Order by most recent dated articles displaying first
      @articles = Article.order("date DESC ")
    end
  end
end
