class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(query) # searches for the query in the title or content of the article
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
end
