# Article model representing blog posts or articles
# 
# Attributes:
#   title (string, required): The title of the article (1-255 characters)
#   content (text, required): The main content of the article (minimum 1 character)
#   author (string, optional): The author's name (maximum 100 characters)
#   date (date, optional): The publication date
#
# Validations:
#   - Title must be present and between 1-255 characters
#   - Content must be present and at least 1 character
#   - Author is optional but limited to 100 characters if provided
#   - Date is optional
#
# Example:
#   article = Article.create!(
#     title: "Getting Started with Rails",
#     content: "Rails is a web application framework...",
#     author: "John Doe",
#     date: Date.today
#   )
class Article < ApplicationRecord
  # Validations
  validates :title, presence: true, length: { minimum: 1, maximum: 255 }
  validates :content, presence: true, length: { minimum: 1 }
  validates :author, length: { maximum: 100 }, allow_blank: true

  # Search functionality
  # 
  # Searches for articles by title or content using case-insensitive LIKE queries
  # 
  # @param query [String] The search term to look for
  # @return [ActiveRecord::Relation] Articles matching the search criteria
  # 
  # Example:
  #   Article.search("Rails") # Returns articles with "Rails" in title or content
  #   Article.search("") # Returns all articles
  def self.search(query)
    if query.blank?
      all
    else
      where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
  end
end
