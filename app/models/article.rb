# Article model
# This model represents an article in the system. An article has a title and content.
# It also includes a search method to find articles based on a query.
class Article < ApplicationRecord
  # Validate that title and content are present before saving
  validates :title, :content, presence: true

  # Class method to search for articles
  # @param query [String] The search query
  # @return [ActiveRecord::Relation] A scope with the search results
  def self.search(query)
    # Use the SQL LIKE operator to find articles where the title or content matches the query
    # The '%' is a wildcard character in SQL that matches any number of characters
    where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
  end
end