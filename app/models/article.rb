class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }

  def self.search(query)
    sanitized_query = sanitize_sql_like(query)
    where('title LIKE :search_query OR content LIKE :search_query', search_query: "%#{sanitized_query}%")
  end
end
