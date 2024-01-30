class Article < ApplicationRecord
    # Validates that all articles have a title and content
    validates :title, presence: true
    validates :content, presence: true

    # Returns articles with titles or content matching the searched term
    def self.search(search)
        where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
    end
end
