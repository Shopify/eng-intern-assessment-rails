class Article < ApplicationRecord
  before_save :set_date
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end

  private
  def set_date
      self.date = Date.today
  end
end
