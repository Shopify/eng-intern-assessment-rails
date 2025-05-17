class Article < ApplicationRecord

    #customer '.search' method that allows users to pass in a string and the method will return a list of article objects that contains 
    #the input string in their content and/or title
    def self.search(search_string)
        if search_string
            where('title LIKE ? OR content LIKE ?', "%#{search_string}%", "%#{search_string}%")
        else
            all
        end
    end
    
end
