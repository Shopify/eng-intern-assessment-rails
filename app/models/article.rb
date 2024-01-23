class Article < ApplicationRecord
    validates :title, :content, presence: true

    def self.search(search)
        if search
            @articles = Article.where("content LIKE CONCAT('%',?,'%') OR title LIKE CONCAT('%',?,'%')",search,search)
        else 
            @articles = Article.all
        end
    end
end
