# File: article.rb
# Programmer Name: Ali Rahbar
# Description: This file is charge of the articles. Search functionality is also implemented here
# Date: 2024-01-18

class Article < ApplicationRecord

  # Added the search functionality
  def self.search(query)
    # return models that have the query in them
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
