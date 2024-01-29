class Article < ApplicationRecord
    # Asserts all articles have a title
    validates :title, presence: true
    # Asserts all articles have contents
    validates :content, presence: true

    # Custom search method to filter articles by title or content
    # @param term [String] the search term entered by the user
    # @return [ActiveRecord::Relation] a collection of articles matching the search term
    def self.search(term)
        # Searches for articles that contain term in title or content
        where("title LIKE ? OR content LIKE ?", "%#{term}%", "%#{term}%")
    end
end
