class Article < ApplicationRecord
before_save :set_timestamp
 
 def self.search(query)
    sanitized_query = sanitize_sql_like(query)
    where("title LIKE :query OR content LIKE :query", query: "%#{sanitized_query}%")
 end

 validates :title, :content, presence: true, if: :should_validate?

 private

 # This is to avoid performing validation when deleting articles, which would prevent us from deleting articles that are in a bad state
 def should_validate?
    new_record? || changed?
 end

 def set_timestamp
    self.updated_at = Time.now
 end
end