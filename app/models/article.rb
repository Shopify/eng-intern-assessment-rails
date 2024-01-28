###############################################################
# Purpose:  Class to represent an article in the application  #
# Author:   Aditya Goel (January 27, 2024)                    #
# Updated:  Aditya Goel (January 27, 2024)                    #
###############################################################

class Article < ApplicationRecord
    # Validation checks on title and content attributes
    # title must be present and unique
    validates :title, presence: true, uniquness: true

    # content must be present and have a minimum character length of 10
    validates :content, presence: true, length: { minimum: 10 }

    # Searches for articles based on given search term
    def self.search(search_term)
        if search_term
        # Coverts title, content and search_term to lower case to make the search case insensitive
        # Any partial match of search_term to the title or content returns the article 
        where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
        else
        # If no search term is provided, return all articles
        all
        end
    end

end
