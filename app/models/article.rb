class Article < ApplicationRecord
  validates :title, :content, presence: true

  # Class Method: Search
  #
  # Searches for articles based on the provided query string.
  #
  # Parameters:
  #   - querystr (String): The search query string.
  #
  # Returns:
  #   - ActiveRecord::Relation: A collection of articles matching the search criteria.
  #
  # Example:
  #   Article.search('Rails') #=> Returns articles with titles or content containing 'Rails'.
  def self.search(querystr)
    query = 'LOWER(title) LIKE ? OR LOWER(content) LIKE ?'

    where(query, "%#{querystr.downcase}%", "%#{querystr.downcase}%")
  end
end
