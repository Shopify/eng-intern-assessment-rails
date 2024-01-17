class Article < ApplicationRecord
    # Assuming the articles table has title, content, author, and date columns
    validates :title, presence: true
    validates :content, presence: true
  
    # Implement the search method used in the tests
    def self.search(search_term)
      where("title LIKE ? OR content LIKE ?", "%#{search_term}%", "%#{search_term}%")
    end
  end