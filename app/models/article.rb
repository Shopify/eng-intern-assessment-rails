class Article < ApplicationRecord
    def self.search(search)
        # find articles that include search params
        Article.where('title LIKE ? OR content LIKE ? OR author LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    end
end
