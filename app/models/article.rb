# title:string
# author:string
# content:string
# date:date

# Article model represents an instance of an article
class Article < ApplicationRecord
  # Title and content cannot be empty and set maximum lengths for data integrity
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :author, length: { maximum: 100 }

  # Search database for titles and content with query
  def self.search(query)
    # Sanitize and parameterize query to prevent SQL injection attacks
    sanitized_query = sanitize_sql_like(query)
    # Wildcard matching will return entries that contain the search term anywhere in the title or content
    where('title LIKE :query OR content LIKE :query', query: "%#{sanitized_query}%")
  end
end
