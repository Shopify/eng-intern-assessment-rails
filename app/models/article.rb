# frozen_string_literal: true

class Article < ApplicationRecord
  # Add validation for title and content attributes
  validates :title, presence: true
  validates :content, presence: true

  # Implement search functionality
  def self.search(query)
    where('title LIKE ? OR content LIKE ?', "%#{query.downcase}%", "%#{query.downcase}%")
  end
end
