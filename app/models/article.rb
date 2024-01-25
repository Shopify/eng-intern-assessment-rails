class Article < ApplicationRecord
    # Validations
    validates :title, presence: true   # Validates presence of title
    validates :content, presence: true # Validates presence of content
    validate :date_cannot_be_in_the_future # Validates that date is not in the future

    # Callbacks
    before_validation :convert_empty_strings_to_nil
  
    # Class method to search articles by title, content, author, or date
    # @param term [String] the search term
    # @return [ActiveRecord::Relation] a collection of articles that match the search term
    def self.search(term)
      return all if term.blank?
  
      where("title LIKE ? OR content LIKE ? OR author LIKE ?",
            "%#{term}%", "%#{term}%", "%#{term}%")
    end
  
    private
  
    # Convert empty strings for author and date to nil
    def convert_empty_strings_to_nil
      self.author = nil if author.blank?
      self.date = nil if date.blank?
    end

    # Validates that date is not in the future
    def date_cannot_be_in_the_future
        if date.present? && date > Date.today
            errors.add(:date, "can't be in the future")
        end
    end
  end
  