class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, length: { maximum: 30 }
  validates :claps, numericality: { only_integer: true, greater_than_or_equal_to: 0 }  
  private

  def self.search(query)
    where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
