# The Article model represents the articles in the system.
class Article < ApplicationRecord
    # Validate presence of a title 
    # Article must have title in order to be valid and save to the database.
    validates :title, presence: true
  
    # Validate presence of content
    # Article must have content 
    validates :content, presence: true

    def self.search(prompt)
      # Checks if a prompt is provided 
      if prompt
        # Performs a case-insensitive search across the title and content columns for the provided term.
        # The search term wrapped with percent to allow for partial matches.
        # Make all letters lowercase to make search case-insensitive.
        where('LOWER(title) LIKE LOWER(:term) OR LOWER(content) LIKE LOWER(:term)', term: "%#{prompt}%")
      else
        # If no prompt, return all articles.
        all
      end
    end
  end
  