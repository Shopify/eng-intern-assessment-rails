class Article < ApplicationRecord
  # Validate that each article has a title and content
  validates :title, presence: true
  validates :content, presence: true

  # Callback to convert empty strings to nil
  before_validation :convert_empty_strings_to_nil

  # Class methods to search for articles
  def self.search(term)
    where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
  end

  private

  def convert_empty_strings_to_nil
    self.author = nil if author.blank?
    self.date = nil if date.blank?
  end
end