class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    where("title like ? OR content like ? OR author like ?", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
