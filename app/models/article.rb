class Article < ApplicationRecord
  # Model validations
  validates :title, presence: true
  # checks if there is content and if the length is at least 10 characters
  validates :content, presence: true, length: { minimum: 10 }

  # Search functionality
  # This method is used to search for articles based on the provided query.
  def self.search(query)
    where("lower(title) LIKE ? OR lower(content) LIKE ?", "%#{query.downcase}%", "%#{query.downcase}%")
  end
end
