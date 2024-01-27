class Article < ApplicationRecord
    # Validation to ensure the presence of title and content
    validates :title, presence: true
    validates :content, presence: true
  
    # Search method for the Article model
    def self.search(search_term)
      where("title LIKE :term OR content LIKE :term", term: "%#{search_term}%")
    end
  end