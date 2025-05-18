# Model to represent articles that are part of the wiki
# Assumptions are that title and content must exist and have some minimum lengths
class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }

  def self.search(query)
    Article.where('title LIKE ? OR content LIKE ? ', "%#{Article.sanitize_sql_like(query)}%",
                  "%#{Article.sanitize_sql_like(query)}%")
  end
end
