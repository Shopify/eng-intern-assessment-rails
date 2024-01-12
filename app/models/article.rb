class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search, ->(query) { where("title LIKE ? or content LIKE ?", "%#{query}%", "%#{query}%") if query.present? }
end
