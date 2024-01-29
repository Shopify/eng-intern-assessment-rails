class Article < ApplicationRecord
  def self.search(text)
    key = "%#{text.downcase}%"
    @article = Article.where("LOWER(title) LIKE ? or LOWER(content) LIKE ? or LOWER(author) LIKE ?", key, key, key)
  end
end
