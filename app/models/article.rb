class Article < ApplicationRecord

    # Reasonable Assumption: title and content are mandatory
    validates :title, presence: true
    validates :content, presence: true
    
    # checks for date inputs
    validate :publish_before_tomorrow

    # performs search query
    # collect all articles with search_term in its title or content attribute
    def self.search(search_term)
        if search_term.present?
          where('title LIKE :term OR content LIKE :term', term: "%#{search_term}%")
        else # return empty list is none is found
          []
        end
    end

    private
  
    # check: if date is present, it shouldn't be in the future
    def publish_before_tomorrow
      return if date.blank?  # Allow date to be nil

      if date > Date.today
        errors.add(:date, "can't be in the future")
      end
    end
end
