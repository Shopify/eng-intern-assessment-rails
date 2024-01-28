class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search, ->(query) { where("title LIKE :query OR content LIKE :query", query: "%#{query}%") }
end
