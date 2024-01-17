class Article < ApplicationRecord
  # Validation for presence and length of title
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }

  # Validation for presence and minimum length of content
  validates :content, presence: true, length: { minimum: 10 }

  # Validation for presence of author
  validates :author, presence: true

  # Validation for presence of date
  validates :date, presence: true

  # Set default values for date and author
  before_validation :set_default_values

  private

  def set_default_values
    self.date ||= Date.current
    self.author ||= 'Unknown Author'
  end

end
