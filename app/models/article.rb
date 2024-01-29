class Article < ApplicationRecord

    # Ensure that articles being saved to the database 
    # meet the following criteria
    validates :title, presence: true
    validates :content, presence: true

    # Search articles based on a search query
    # If search is present, perform a database query for articles 
    # matching titles or content
    # If no search is present, return all articles
    def self.search(search)
        if search
            where(["title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%"])
        else    
            all
        end
    end
end
