# The Article model represents an article in the application.
# Each article has a title and content, and possibly other attributes as the application grows in complexity.
class Article < ApplicationRecord
    # Searches for articles where the title or content matches the provided search term.
    #
    # @param term [String] the term to search for in the title and content of the articles
    # @return [ActiveRecord::Relation] a collection of articles where the title or content matches the search term
    def self.search(term)
        where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
    end
end