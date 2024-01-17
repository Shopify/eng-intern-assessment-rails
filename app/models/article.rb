class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(text)
    if query.present?
      where("title LIKE ? OR content LIKE ?",
      "%#{sanitize_sql_like(text)}%", "%#{sanitize_sql_like(text)}%")
    else
      all
    end
  end
end
