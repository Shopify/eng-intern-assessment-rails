class Article < ApplicationRecord
  # Validations
  validates :title, :content, :author, presence: true

  # Callbacks
  before_create :set_creation_date

  # Search functionality
  def self.search(search_term)
    if search_term
      where('LOWER(title) LIKE LOWER(:search) OR LOWER(content) LIKE LOWER(:search) OR LOWER(author) LIKE LOWER(:search)', search: "%#{search_term}%")
    else
      all
    end
  end

  private

  # automatically updates the date as new records are put in
  def set_creation_date
    self.date = Time.current
  end
end
