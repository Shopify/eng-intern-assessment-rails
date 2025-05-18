class Article < ApplicationRecord
    def self.search(substr)
        Article.where("title LIKE ? OR content LIKE ?", "%#{substr}%", "%#{substr}%")
    end
end
