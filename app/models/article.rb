class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(key)
    sanitized_key = sanitize_sql_like(key)
    where("title LIKE ? OR content LIKE ?", "%#{sanitized_key}%",  "%#{sanitized_key}%")
  end
end
