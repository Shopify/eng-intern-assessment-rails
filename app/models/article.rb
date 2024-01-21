class Article < ApplicationRecord
  belongs_to :writer
  attribute :date, :date
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
