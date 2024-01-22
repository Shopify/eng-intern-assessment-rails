# File: article.rb
# Programmer Name: Ali Rahbar
# Description: This file is charge of the articles. Search functionality is also implemented here
# Date: 2024-01-18

class Article < ApplicationRecord

  # check to make sure all values exist
  validates :title, presence: true
  validates :content, presence: true

  # Set default values
  after_initialize :set_defaults


  # Added the search functionality
  def self.search(query)
    # return models that have the query in them
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end

  private

  # Set default values only if there is no values already set for them
  def set_defaults
    self.date ||= Date.today
    self.author ||= "Anonymous"
  end
end
