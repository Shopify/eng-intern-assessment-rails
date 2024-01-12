class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true

  # Add current date before creating article
  before_create :set_current_date

  # This function returns all articles that contains the string query
  # in the title or content attribut
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end

  private
  def set_current_date
    self.date = Date.current
  end
end
