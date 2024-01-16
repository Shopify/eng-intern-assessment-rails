class Article < ApplicationRecord
  # Validations
  validates :title, :content, presence: true

  # Search functionality
  def self.search(search_term)
    where("title LIKE ? OR content LIKE ?", "%#{search_term}%", "%#{search_term}%")
  end
end
