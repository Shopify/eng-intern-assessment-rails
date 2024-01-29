class Article < ApplicationRecord
  validates :title, presence: { message: "Title can not be blank!" }, uniqueness: true
  validates :content, presence: { message: "Content can not be blank!" }, length: { minimum: 5, message: "Content must have at least 5 characters" }
  validate :validate_future_date

  before_validation :set_default_date

  # Search for articles by title, content, or author
  def self.search(query)
    if query.present?
      sanitized_query = query.gsub(/\s+/, ' ') # Replace consecutive spaces with a single space
      where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{sanitized_query}%", "%#{sanitized_query}%", "%#{sanitized_query}%")
    else
      none
    end
  end

  private

  # Ensure date selected is not in the future
  def validate_future_date
    errors.add(:date, "Date cannot be in the future") if date.present? && date > Date.current
  end

  # If no date is selected, set it to today's date
  def set_default_date
    self.date ||= Date.current
  end
end
