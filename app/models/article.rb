class Article < ApplicationRecord
  attribute :date, :date, default: Date.today

  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
