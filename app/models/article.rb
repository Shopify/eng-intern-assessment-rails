# frozen_string_literal: true

# Represents an article in the blog with title, content, author, and date.
class Article < ApplicationRecord
  # Check that article meets minimum requirements of tests
  validates :title, :content, presence: true

  # Search an article's title, content, author.
  def self.search(query)
    where('title LIKE ? OR content LIKE ? OR author LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
