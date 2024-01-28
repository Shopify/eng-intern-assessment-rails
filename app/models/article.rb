###############################################################
# Purpose:  Class to represent an article in the application  #
# Author:   Aditya Goel (January 27, 2024)                    #
# Updated:  Aditya Goel (January 27, 2024)                    #
###############################################################

class Article < ApplicationRecord
    # Validation checks on title and content attributes
    # title must be present and unique and have a maximum character length of 50
    validates :title, presence: true, uniqueness: true, length: { maximum: 50 }

    # content must be present and have a maximum character length of 500
    validates :content, presence: true, length: { maximum: 500 }

    # Searches for articles based on given search term
    def self.search(search_term)
        if search_term
        # Coverts title, content and search_term to lower case to make the search case insensitive
        # Any partial match of search_term to the title or content returns the article 
        where("lower(title) LIKE ? OR lower(content) LIKE ?", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
        else
        # If no search term is provided, return all articles
        all
        end
    end

end
