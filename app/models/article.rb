class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  def self.search(keyword)
    if keyword
      # return articles with title or content containing the query string
      sanitized_keyword = Article.sanitize_sql_like(keyword)
      Article.where('title LIKE ? OR content LIKE ?', '%' + sanitized_keyword + '%', '%' + sanitized_keyword + '%')
    else
      Article.all
    end
  end
end
