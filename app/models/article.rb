class Article < ApplicationRecord
    validates_presence_of :title
    validates_presence_of :content

    def self.search(query)
        where("title LIKE ? OR content LIKE ? OR author LIKE ? OR date LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
    end
end
