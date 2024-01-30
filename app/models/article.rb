class Article < ApplicationRecord
    
    # Validations
    validates :title, presence: true, uniqueness: true
    validates :content, presence: true
  
    # Public: Performs a search across articles based on a provided search term.
    # Finds articles where the title or content includes the search term.
    #
    # search_term - The String to search for in the article's title and content. 
    #               This method supports partial matching and is case-insensitive.
    #
    # Errors - search_term must be a String, or else an ArgumentError is raised
    #
    # Returns an ActiveRecord::Relation object containing the found articles if a search term is provided.
    # Returns empty ActiveRecord::Relation object if no search term is provided or if it's nil.
    def self.search(search_term)
        unless search_term.is_a?(String)
            raise ArgumentError, "Search term must be a string."
        end
        if search_term
            # The `%` wildcard allows for partial matches.
            where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
        else
            none
        end
    end
end
  