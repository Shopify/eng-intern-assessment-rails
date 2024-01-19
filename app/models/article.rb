class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true
  validates :date, presence: true

  def self.search(text)
    if text.present?
      where("title LIKE ? OR content LIKE ?",
      "%#{sanitize_sql_like(text)}%", "%#{sanitize_sql_like(text)}%")
    else
      all
    end
  end
end
