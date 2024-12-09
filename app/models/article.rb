class Article < ApplicationRecord
    # Requires title and content field to be filled
    validates :title, presence: true
    validates :content, presence: true
  
    # Add search method for matching title or content
    def self.search(search_term)
      if search_term
        where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
      else
        all
      end
    end
  end
  