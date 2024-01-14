class Article < ApplicationRecord
    # Make title and content required fields
    validates :title, presence: true
    validates :content, presence: true

    def self.search(search_key)
        # Interpolate the wildcard % to find anything like search_key
        where("content LIKE ? OR title LIKE ?", "%#{search_key}%", "%#{search_key}%")
    end
end
