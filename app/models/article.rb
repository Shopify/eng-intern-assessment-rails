class Article < ApplicationRecord
    # Asserts all articles have a title
    validates :title, presence: true
    # Asserts all articles have contents
    validates :content, presence: true

    # Search method for articles
    def self.search(term)
        # Searches for articles that contain term in title or content
        where("title LIKE ? OR content LIKE ?", "%#{term}%", "%#{term}%")
    end
end
