# app/models/article.rb
class Article < ApplicationRecord
  # Validations
  validates :title, :content, presence: true  # Removed author from mandatory fields

  # Callbacks
  before_create :set_creation_date

  # Search functionality
  def self.search(search_term)
    if search_term
      where('LOWER(title) LIKE ? OR LOWER(content) LIKE ? OR LOWER(author) LIKE ?', "%#{search_term.downcase}%", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
    else
      all
    end
  end

  private

  # automatically updates the date as new records are put in
  def set_creation_date
    self.date = Time.current.to_date  # Ensure the date is saved without time
  end
end
