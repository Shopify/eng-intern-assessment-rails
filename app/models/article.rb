# app/models/article.rb

# Public: Model representing an article in the application.
class Article < ApplicationRecord
  # Public: Validation rules for article attributes.
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  # Public: Search articles based on a search term.
  #
  # search_term - The String representing the term to search for in titles and content.
  #
  # Returns an ActiveRecord::Relation representing the articles matching the search term.
  def self.search(search_term)
    if search_term
      where("title LIKE ? OR content LIKE ?", "%#{search_term}%", "%#{search_term}%")
    else
      all
    end
  end
end
