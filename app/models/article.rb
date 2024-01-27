# The Article model represents articles in the system with validations for required fields
# and a search method to find articles containing a search term.
class Article < ApplicationRecord
  # Ensures that an article must have a title and content before saving.
  validates :title, presence: true
  validates :content, presence: true
  # Add any other validations you might need based on the tests.
  
  # Search functionality: Returns articles containing the search term in the title or content.
  # @param search_term [String] The term to search for in articles.
  # @return [ActiveRecord::Relation] A collection of articles matching the search term.
  def self.search(search_term)
    if search_term
      where('title LIKE :term OR content LIKE :term', term: "%#{search_term}%")
    else
      all
    end
  end
end
