class Article < ApplicationRecord

    def self.search(search)
        where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
    end
end
