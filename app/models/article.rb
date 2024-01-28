class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # Default date if not explicitly set
  before_create -> { self.date ||= Date.today }

  scope :search, ->(query) { where("title LIKE :query OR content LIKE :query", query: "%#{query}%") }
end
