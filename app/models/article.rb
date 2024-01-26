class Article < ApplicationRecord
  # Validations
  validates :title, presence: true   # Validates presence of title
  validates :content, presence: true # Validates presence of content
  validate :check_date # Validates that date is not in the future



  # Class method to search articles by title, content, author, or date
  # @param term [String] the search term
  # @return [ActiveRecord::Relation] a collection of articles that match the search term
  def self.search(term)
    return all if term.blank?

    where("title LIKE ? OR content LIKE ? OR author LIKE ?",
          "%#{term}%", "%#{term}%", "%#{term}%")
  end

  # Validates that date is not in the future
  def check_date
    if date.present? && date > Date.today
        errors.add(:date, "Invalid Date Entry")
    end
end
end
