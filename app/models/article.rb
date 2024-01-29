# app/models/article.rb

# The Article class represents the model for the articles in our application.
# It inherits from ApplicationRecord, which is the base class for all models provided by Rails.
class Article < ApplicationRecord
    # attr_accessor creates getter and setter methods for the specified attributes.
    # In this case, it creates methods for the author and date attributes.
    attr_accessor :author, :date
  
    # The search class method allows us to search for articles by term.
    # It uses the 'LIKE' SQL operator to search the 'title' and 'content' fields for the specified term.
    # So, this method will return any articles where the title or content contains the term.
    def self.search(term)
      where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
    end
  end