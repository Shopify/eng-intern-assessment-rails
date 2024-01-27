# The Article class represents an article in the application.
class Article < ApplicationRecord
  # Validates that the title is present.
  validates :title, presence: true

  # Validates that the content is present and has a minimum length of 10 characters.
  validates :content, presence: true, length: { minimum: 10 }

  # Searches for articles based on the given search term.
  def self.search(search)
    if search
      where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end
