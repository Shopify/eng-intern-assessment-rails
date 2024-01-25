class Article < ApplicationRecord
  # Title and content can't be empty
  validates :title, :content, presence: true

  def self.search(query)
    where('title LIKE :query OR content LIKE :query OR author LIKE :query', query: "%#{query}%")
  end
end
