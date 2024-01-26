# title:string
# author:string
# content:string
# date:date

# Article model represents an instance of an article
# Title and content cannot be empty and set maximum lengths for data integrity
class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100}
  validates :content, presence: true, length: { maximum: 1000 }

  def self.search(query)
    sanitized_query = ActiveRecord::Base.sanitize_sql_like(query)
    where('title LIKE :query OR content LIKE :query', query: "%#{sanitized_query}%")
  end
end
