# frozen_string_literal: true

class Article < ApplicationRecord
  # Implement search functionality
  def self.search(query)
    where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
  end
end
