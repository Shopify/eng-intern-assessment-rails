class Article < ApplicationRecord
  # Validates presence of title and content fields
  validates :title, presence: true
  validates :content, presence: true

  # Defines a class method to search for articles based on a query
  def self.search(query)
    where("title LIKE :query OR content LIKE :query", query: "%#{query}%")
  end
end
