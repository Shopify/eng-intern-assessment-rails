 # Model for managing articles in the application.
class Article < ApplicationRecord
  
  # Validations to ensure data integrity:
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true, uniqueness: true
  before_validation :validate_date_not_in_future

  # Case Insensitive Search function for retrieving articles based on search criteria.
  # It allows users to search for articles by title, content, or author.
  def self.search(search_term)
    if search_term
      term = search_term.downcase
      where('LOWER(title) LIKE :term OR LOWER(content) LIKE :term OR LOWER(author) LIKE :term', term: "%#{term}%")
    else
      all
    end

  end
  # Validation method to check if the date is not in the future
  def validate_date_not_in_future
    if date && date > Date.today
      errors.add(:date, "cannot be a future date")
    end
  end
end
