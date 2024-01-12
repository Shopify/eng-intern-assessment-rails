class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true

  # Add current date before creating article
  before_create :set_current_date

  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end

  private
  def set_current_date
    self.date = Date.current
  end
end
