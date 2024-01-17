class Article < ApplicationRecord
    # title and content are mandatory. date and author are not 
    validates :title, presence: true
    validates :content, presence: true

    #Returns all articles that contains the key from db
    def self.search(search)
        
        if search
            key = "%#{search}%"
            @result = where("title LIKE ? or content LIKE ? or author LIKE?", key, key, key)
            
        else 
            @result = Article.all
        end 
    end
end
