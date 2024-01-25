class Article < ApplicationRecord
  def self.search(search)
    sanitized_search = sanitize_sql(search)
    search_string = "%#{sanitized_search}%"
    where("title LIKE ? or content LIKE ?", search_string, search_string)
  end
end
