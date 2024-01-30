# The Article model represents an article in the application.
class Article < ApplicationRecord
    # Validates that the title is present.
    validates :title, presence: true

    # Validates that the content is present.
    validates :content, presence: true

    # Validates the uniqueness of the title.
    validates_uniqueness_of :title

    # Searches for articles based on a query string.
    def self.search(query)
        @article = self.where("title LIKE ? or content LIKE ?", "%#{query}%",  "%#{query}%")
    end
end