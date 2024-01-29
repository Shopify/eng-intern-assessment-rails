class Article < ApplicationRecord

  # Validation to check for the presence of both the title and content, if they are not at least one
  validates :title, presence: true
  validates :content, presence: true

  # Define the class search method on the Article model. It uses the SQL "LIKE" keyword to find a list of articles
  # which contains either the provided query in the title or content
  def self.search(search_query)
    where("title LIKE ? or content LIKE ?", "%" + search_query + "%", "%" + search_query + "%")
  end
end
