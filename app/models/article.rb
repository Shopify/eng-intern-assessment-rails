class Article < ApplicationRecord

    # validations to the model
    validates :title, presence: true
    validates :content, presence: true

    # search function 
    def self.search(search_term)
        if search_term
          term = search_term.downcase
          where('LOWER(title) LIKE :term OR LOWER(content) LIKE :term OR LOWER(author) LIKE :term', term: "%#{term}%")
        else
          all
        end
    end    
end
