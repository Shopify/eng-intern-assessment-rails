class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    query = query.downcase
    where("LOWER(title) LIKE :query OR LOWER(content) LIKE :query OR LOWER(author) LIKE :query", query: "%#{query}%")
  end

end
