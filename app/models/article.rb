class Article < ApplicationRecord

  # Added the search functionality
  def self.search(query)
    # return models that have the query in them
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
