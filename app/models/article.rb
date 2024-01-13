class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search, ->(query) { where("LOWER(title) LIKE ? or LOWER(content) LIKE ?", "%#{query.downcase}%", "%#{query.downcase}%") if query.present? }
end
