class Article < ApplicationRecord
  ##I feel at the minimum title and content should be required
  ##Chosen minimums are just for sanity
  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true, length: {minimum: 10}

  def self.search(query)
    Article.where("title LIKE ? OR content LIKE ? ",  '%' + Article.sanitize_sql_like(query) + '%', '%' + Article.sanitize_sql_like(query) + '%')
    # Article.where("title Like ?",  '%' + Article.sanitize_sql_like(query) + '%')
  end
end
