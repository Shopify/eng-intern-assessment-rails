# Article model with validations and search scope
class Article < ApplicationRecord
  validates :title, length: { maximum: 100 }, presence: true
  validates :content, length: { maximum: 1000 }, presence: true
  
  scope :search, ->(query) {
    where("title LIKE :query OR content LIKE :query", query: "#{query}%")
  }
end