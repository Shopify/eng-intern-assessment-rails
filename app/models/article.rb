class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10, message: "is too short (minimum is 10 characters)" }
    validates :author, length: { maximum: 50, message: "is too long (maximum is 50 characters)" }
    validate :date_cannot_be_in_the_future
    # Ensure that the article's publication date is not set in the future,
    # as articles are expected to be written and published on or before the present date.
    def date_cannot_be_in_the_future
      if date.present? && date > Date.today
        errors.add(:date, "cannot be in the future")
      end
    end
  
    # Search articles based on title or content
    # This method uses ActiveRecord parameterized queries to prevent SQL injection.
    #
    # @param [String] query - The search query
    # @return [ActiveRecord::Relation] - The matching articles
    def self.search(query)
      where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
  end
