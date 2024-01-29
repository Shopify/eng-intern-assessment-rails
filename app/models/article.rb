class Article < ApplicationRecord
  self.table_name = "articles"

  # Given text, return all results with a title/content that contains said text
  def self.search(text)
    @results = Article.all.where("title LIKE ? OR content LIKE ?", "%#{text}%", "%#{text}%")
  end
end