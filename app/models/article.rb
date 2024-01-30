class Article < ApplicationRecord
  # Although not explicitly required by the tests, logically it makes sense that
  # an encyclopedia article should have a title and content.
  # The author and date are optional, as per the tests.
  validates :title, presence: true
  validates :content, presence: true

  # Searches for articles that match the given query in the title or content.
  #
  # @param query [String] The search query.
  # @return [ActiveRecord::Relation] The collection of articles that match the query.
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
