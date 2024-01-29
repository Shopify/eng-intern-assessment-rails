class Article < ApplicationRecord
  self.table_name = "articles"

  # Given text, return all results with a title/content/author that contains said text
  def self.search(text)
    @results = Article.all.where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{text}%", "%#{text}%", "%#{text}%")
  end
end