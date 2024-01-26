# frozen_string_literal: true

class Article < ApplicationRecord
  # Validates title is present
  validates :title, presence: true
  # Validates content is present
  validates :content, presence: true

  # Searches for articles based on title or content
  def self.search(search)
    if search
      # Returns articles that match search if search is True
      # Articles are searched by title or content
      Article.where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%")
    else
      # Returns all articles if search is False or nil
      Article.all
    end
  end
end
