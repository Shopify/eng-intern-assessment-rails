class Article < ApplicationRecord
  # Validation: Ensure presence of title and content for every article
  validates :title, presence: true
  validates :content, presence: true

  # Method for searching articles based on title, content, or author
  def self.search(query)
    where("title LIKE :query OR content LIKE :query OR author LIKE :query", query: "%#{query}%")
  end
end