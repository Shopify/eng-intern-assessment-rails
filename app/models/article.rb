class Article < ApplicationRecord
    def self.search(search)
        Article.where('title LIKE ? OR content LIKE ? OR author LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    end
end
