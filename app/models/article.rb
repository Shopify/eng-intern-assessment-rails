class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # Searches for articles based on a wildcard by both title and contents and returns
  # a collections of articles matching the query
  #
  # query - A string used to search for articles. Articles with titles or content matching
  #         this string will be included in the collection
  #
  # returns a collection of articles.
  def self.search(query)
    where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
  end
end
