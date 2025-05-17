class Article < ApplicationRecord
    # Define a class-level search method that searches for articles based on a provided term.
    # If a term is present, it performs a SQL query to find articles with titles or content
    # containing the term (case-insensitive search using SQL's LIKE operator).
    # If no term is provided, it returns all articles.
    #
    # Params:
    # - term: The search term to be used for filtering articles.
    #
    # Returns:
    # - An ActiveRecord relation representing the search results or all articles.
    def self.search(term)
      if term.present?
        where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
      else
        all
      end
    end
  end
  