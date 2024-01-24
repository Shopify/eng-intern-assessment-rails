class Article < ApplicationRecord
    # Validates that the title is present
    validates :title, presence: true

    # Validates that date, if entered, is current or in the past
    validate :date_must_be_in_the_past_or_today, if: -> { date.present? }


    # Search articles by keywords
    def self.search(search_term)
        # SQLite compatible case-insensitive search
        # search range includes title, content, and author
        where("LOWER(title) LIKE ? OR LOWER(content) LIKE ? OR LOWER(author) LIKE ?", 
              "%#{search_term.downcase}%", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
    end

    private

    def date_must_be_in_the_past_or_today
        if date > Date.today
        errors.add(:date, "can't be in the future")
        end
    end
      
end