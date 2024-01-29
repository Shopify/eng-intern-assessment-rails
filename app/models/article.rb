class Article < ApplicationRecord
  # article needs title
  validates :title, presence: true

  # article cannot have a date from the future
  validate :date_cannot_be_in_the_future

  def date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end

  # search for articles
  def self.search(search_term)
    if search_term
      where('title LIKE ? OR content LIKE ? OR author LIKE ?', "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
    else
      all
    end
  end
end