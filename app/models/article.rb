class Article < ApplicationRecord
  
  # Validation: Ensures the presence of a title and content.
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 5 }

  # Performs a search for articles based on the provided query.
  # If a query is present, it filters articles by title, content, and author.
  # If no query is provided, it returns all articles.
  #
  # @param query [String] The search query.
  # @return [ActiveRecord::Relation] A collection of articles matching the search query.
  def self.search(query)
    if query.present?
      where("title LIKE :query OR content LIKE :query OR author LIKE :query", query: "%#{query}%")
    else
      all
    end
  end

end
