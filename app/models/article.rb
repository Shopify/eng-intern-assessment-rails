class Article < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true

  # Given a query, return an article where  the title or content matches the query.
  # The Where query is specifically designed for SQLite
  def self.search(query)
    if query.present?
      where("lower(title) LIKE ? OR lower(content) LIKE ?", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%")
    else
      all
    end
  end
end
