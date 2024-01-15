# frozen_string_literal: true

# The Article model represents an article in the application.
# It includes validations to ensure data integrity and a search method
# to find articles based on a search term.
class Article < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :content, presence: true, length: { minimum: 10, maximum: 5000 }

  # Ensures author's name only consists of letters and spaces and has a reasonable length.
  validates :author, format: { with: /\A[a-zA-Z\s]+\z/, message: 'must only consist of letters and spaces' },
                     allow_blank: true, length: { maximum: 100 }

  def self.search(search_term)
    if search_term.present?
      sanitized_term = ActiveRecord::Base.sanitize_sql_like(search_term)
      where('title LIKE :search OR content LIKE :search', search: "%#{sanitized_term}%")
    else
      all
    end
  end
end
