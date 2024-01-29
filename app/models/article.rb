class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    sanitized_query = "%#{sanitize_sql_like(query)}%"
    Article
      .where("title LIKE ?", sanitized_query)
      .or(where("content LIKE ?", sanitized_query))
  end
end
