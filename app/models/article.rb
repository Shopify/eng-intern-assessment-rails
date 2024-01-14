class Article < ApplicationRecord
  # Validate that each article has a title and content
  validates :title, presence: true
  validates :content, presence: true

  # Callback to convert empty strings to nil
  before_validation :convert_empty_strings_to_nil

  # Class methods to search for articles
  def self.search(term)
    where('title LIKE ? OR content LIKE ? OR author LIKE ? OR date LIKE ?', "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%")
  end

  private

  # Assigns author and/or date as nil if input is blank
  def convert_empty_strings_to_nil
    self.author = nil if author.blank?
    self.date = nil if date.blank?
  end
end