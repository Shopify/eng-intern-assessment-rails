class Article < ApplicationRecord
  validates :title, :content, :author, :date, presence: true

  def self.search(query)
    where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
  end
end
