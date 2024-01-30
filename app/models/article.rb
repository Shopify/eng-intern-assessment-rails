class Article < ApplicationRecord
    def self.search( query_string )
        Article.where(["title LIKE ? OR content LIKE ?", "%#{query_string}%", "%#{query_string}%"])
    end
end
