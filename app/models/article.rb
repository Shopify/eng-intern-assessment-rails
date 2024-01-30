class Article < ApplicationRecord
  # Ensure articles have a non-empty title and non-empty content
  validates :title, presence: true
  validates :content, presence: true

  # Search articles by title and content
  def self.search(query)
    # We want to interpret characters like '%' and '_' in the search query
    # literally, because users aren't familiar with sqlite's search syntax.
    # So we use `sanitize_sql_like` before querying the database. See
    # https://guides.rubyonrails.org/active_record_querying.html section 3.2.2 
    # for more information on sanitizing LIKE queries.
    where('title LIKE :sanitized_query OR content LIKE :sanitized_query',
          { sanitized_query: "%#{sanitize_sql_like(query)}%" })
  end
end
