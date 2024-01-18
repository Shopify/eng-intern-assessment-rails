class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum:10 }
  validate :date_cannot_be_in_the_future

  before_validation :set_defaults


  # Validates that the inputted date cant be in the future
  def date_cannot_be_in_the_future
    errors.add(:date, "Date can't be in the future") if
      !date.blank? and date > Date.today
  end

  # Sets the default values if they are not filled
  def set_defaults
    self.author = "Anonymous" if self.author.blank?
    self.date ||= Date.today
  end
end
