# The Article model t5hat is stored in the database
class Article < ApplicationRecord
  # Public: Validates the presence of title and content for an article.
  validates :title, presence: true
  validates :content, presence: true

  # Public: Searches for articles based on a query string.
  #
  # Parameters:
  #   query - The search query string.
  #
  # Returns an ActiveRecord::Relation representing the search results.
  #
  # Examples
  #
  #   Article.search('Lorem ipsum')
  #   # => Returns articles containing 'Lorem ipsum' in the title or content.
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
