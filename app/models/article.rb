class Article < ApplicationRecord
    # Made the search simple by searching for titles or contents of the articles
    def self.search(search_term)
      where("title LIKE ? OR content LIKE ?", "%#{search_term}%", "%#{search_term}%")
    end
  end
  