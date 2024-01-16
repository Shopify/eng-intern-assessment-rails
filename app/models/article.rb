class Article < ApplicationRecord
  # Validations
  validates :title, :content, :author, presence: true

  # Callbacks
  before_create :set_creation_date

  # Search functionality
  def self.search(search_term)
    where("title LIKE ? OR content LIKE ?", "%#{search_term}%", "%#{search_term}%")
  end

  private

  # automatically updates the date as new records are put in
  def set_creation_date
    self.date = Time.current
  end
end
