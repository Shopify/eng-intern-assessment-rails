class Article < ApplicationRecord
    def self.search(search_term)
      if search_term
        where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
      else
        all
      end
    end
    end