class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  def self.search(query)
    # This search implementation makes the assumption that the database
    # supports this SQL syntax. Locally, this works with SQLite3.
    where('title LIKE :query OR content LIKE :query', query: "%#{query}%")
  end
end
