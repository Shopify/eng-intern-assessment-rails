class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(search_term)
    # Search only takes into account articles' "title" and "content" fields
    return Article.where("title LIKE ?", "%#{search_term}%").or(Article.where("content LIKE ?", "%#{search_term}%"))
  end
end
