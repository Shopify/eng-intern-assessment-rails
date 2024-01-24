class Article < ApplicationRecord
    # title, content, and author cannot be null
    validates :title, presence: true
    validates :content, presence: true

    # define search method where query can be a substring of title or content
    def self.search(query)
        where("title LIKE :query OR content LIKE :query", query: "%#{query}%")
    end
end
