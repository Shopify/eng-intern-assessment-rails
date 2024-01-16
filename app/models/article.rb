class Article < ApplicationRecord
    # title and content are mandatory attributes for an article
    validates_presence_of :title
    validates_presence_of :content

    validates :title, uniqueness: true

    def self.search(query)
        where("title LIKE ? OR content LIKE ? OR author LIKE ? OR date LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
    end
end
