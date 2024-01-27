class Article < ApplicationRecord
 before_validation :set_date, on: create

 # We want to validate that articles have all fields completed before saving them to ensure the traceability of articles within our Encyclopedia
 validates :title, presence: true
 validates :content, presence: true
 validates :date, presence:true
 validates :author, presence:true
 
 def self.search(query)
    sanitized_query = sanitize_sql_like(query)
    where("title LIKE :query OR content LIKE :query", query: "%#{sanitized_query}%")
 end

 private
 
 def set_date
    self.date ||= Date.current
 end
end