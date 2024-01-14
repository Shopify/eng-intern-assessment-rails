#   File: article.rb
#   Description: This file contains the Article class, which represents the model for articles.
#                It includes validations for title, content, author, and claps (equivalent to Medium.com claps), as well as a search method.

class Article < ApplicationRecord
  # Validate presence and length constraints for the title.
  validates :title, presence: true, length: { maximum: 100 }

  # Validate presence and length constraints for the content.
  validates :content, presence: true, length: { minimum: 10, maximum: 1000 }

  # Validate length constraint for the author.
  validates :author, length: { maximum: 30 }

  # Validate numericality and non-negativity for the claps attribute.
  validates :claps, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  # Search for articles based on a query for title, content, or author.
  # Params: query - the search query
  def self.search(query)
    where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
