class Article < ApplicationRecord
    def self.search(keyword)
        Article.where("title LIKE ? OR content LIKE ?", '%'+keyword+'%', '%'+keyword+'%')
    end
end
