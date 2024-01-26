# title:string
# author:string
# content:string
# date:date

# Article model represents an instance of an article
class Article < ApplicationRecord
  # Title and content cannot be empty and set maximum lengths for data integrity
  validates :title, presence: true, length: { maximum: 100}
  validates :content, presence: true, length: { maximum: 1000 }

  # Search database for titles and content with query
  def self.search(query)
    return all if query.nil? || query.strip.empty?

    sanitized_query = ActiveRecord::Base.sanitize_sql_like(query)
    where('title LIKE :query OR content LIKE :query', query: "%#{sanitized_query}%")
  end
end
