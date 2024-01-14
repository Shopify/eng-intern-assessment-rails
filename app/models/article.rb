class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    
    # checks for date inputs
    validate :publish_before_tomorrow

    # performs search query
    def self.search(search_term)
        if search_term.present?
          where('title LIKE :term OR content LIKE :term', term: "%#{search_term}%")
        else # return nothing is none is found
          []
        end
    end

    private
  
    # check if date is valid
    def publish_before_tomorrow
      return if date.blank?  # Allow d to be nil

      if date > Date.today
        errors.add(:date, "can't be in the future")
      end
    end
end
