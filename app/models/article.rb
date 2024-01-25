class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(search)
    sanitized_search = sanitize_sql(search)
    search_string = "%#{sanitized_search}%"
    where("title LIKE ? or content LIKE ? or author LIKE ?", search_string, search_string, search_string)
  end
end
