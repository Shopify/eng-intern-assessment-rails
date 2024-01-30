class Article < ApplicationRecord
    # ensure that the all the data needed for an article is present
    validates :title, presence: true
    validates :content, presence: true

    # meta data are optional 
    validates :author, presence: false
    validates :date, presence: false

    # define the search functionality
    def self.search(search)
        if search
            search = search.downcase # lower case for search for better match
            where("LOWER(title) LIKE ? or LOWER(author) LIKE ? or LOWER(content) LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
        else
            all
        end
    end
end
