class Article < ApplicationRecord
    
    # Validations
    validates :title, presence: true
    validates :content, presence: true
  
    # Public: Performs a search across articles based on a provided search term.
    # Finds articles where the title or content includes the search term.
    #
    # search_term - The String to search for in the article's title and content. 
    #               This method supports partial matching and is case-insensitive.
    #
    # Returns an ActiveRecord::Relation object containing the found articles if a search term is provided.
    # Returns empty ActiveRecord::Relation object if no search term is provided or if it's nil.
    def self.search(search_term)
      if search_term
        # The `%` wildcard allows for partial matches.
        where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
      else
        none
      end
    end
  end
  