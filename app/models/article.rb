# app/models/article.rb
class Article < ApplicationRecord
    validates :title, :content, presence: true
  
    # Returns articles where the title or content matches the query
    def self.search(query)
      where(search_condition, query: "%#{query}%")
    end
  
    private
  
    # Defines the condition used in the search method
    def self.search_condition
      "title LIKE :query OR content LIKE :query"
    end
  end