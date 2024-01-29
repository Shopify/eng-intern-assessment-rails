class Article < ApplicationRecord
    # ensure that the title and content are present
    validates :title, presence: true
    validates :content, presence: true

    # finds articles whose title, content, author, or date are related the search query
    def self.search(query)
        where("title LIKE :query OR content LIKE :query OR author LIKE :query OR date LIKE :query", query: "%#{query}%")
      end
end