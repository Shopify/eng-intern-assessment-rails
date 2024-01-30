# app/models/article.rb

class Article < ApplicationRecord
  # Validations
  validates :title, presence: true
  validates :content, presence: true
  # Make author and date optional or provide a mechanism to handle their absence
  validates :author, presence: true, unless: -> { author.blank? }
  validates :date, presence: true, unless: -> { date.blank? }

  # Add any relationships here if you have any. For example:
  # belongs_to :author

  # Add the search method and other functionalities below...
  def self.search(search_term)
    if search_term
      term = "%#{search_term.downcase}%"
      where('LOWER(title) LIKE :term OR LOWER(content) LIKE :term', term: term)
    else
      all
    end
  end
end
