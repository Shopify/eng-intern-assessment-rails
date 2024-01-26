class Article < ApplicationRecord
  before_save :set_date

  # Title and content are needed, author is optional
  validates :title, presence: true
  validates :content, presence: true

  # Search for match in title or content
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end

  private

  # Update the date field when article is created or updated
  def set_date
      self.date = Date.today
  end
end
