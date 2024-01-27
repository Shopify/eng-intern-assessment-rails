class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validate :future_date

  before_validation :default_date

  # Search for title/content
  def self.search(key)
    Article.all.where("title LIKE ? OR content LIKE ?", "%#{key}%", "%#{key}%")
  end

  # Ensure date cannot be in the future
  def future_date
    if date.present? && date > Date.today
      errors.add(:date, "cannot be a future date!")
    end
  end

  def default_date
    self.date ||= Date.today
  end
end
