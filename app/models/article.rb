class Article < ApplicationRecord
    # title and content are mandatory. date and author are not 
    validates :title, presence: true
    validates :content, presence: true

    # retuns all articles that contains the key
    def self.search(search_key)
        
        if search_key
            key = "%#{search_key}%"
            result = where("title LIKE ? or content LIKE ? or author LIKE?", key, key, key)
            
        else
            result = none
        end

        return result    
    end
end
