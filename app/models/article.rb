class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  def self.search(text)
    key = "%#{text.downcase}%"
    @article = Article.where("LOWER(title) LIKE ? or LOWER(content) LIKE ? or LOWER(author) LIKE ?", key, key, key)
  end
end
