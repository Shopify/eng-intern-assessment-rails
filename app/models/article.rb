class Article < ApplicationRecord
    # Validation for the 'title' attribute: it must be present and unique.
    validates :title, presence: true, uniqueness: true

    # Validation for the 'content' attribute: it must be present and at least 10 characters long.
    validates :content, presence: true, length: { minimum: 10 }

    # Class method 'search' that allows searching for articles based on a search term.
    def self.search(search_term)
        # Checks if a search term is provided.
        if search_term
        # If a search term is provided, the method performs a query on the articles table.
        # It looks for articles where the title or content contains the search term.
        # The 'LIKE' operator is used for partial matching, and '%' is a wildcard that matches any sequence of characters.
        where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
        else
        # If no search term is provided, the method returns all articles.
        all
        end
    end
end