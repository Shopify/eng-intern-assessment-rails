class Article < ApplicationRecord

    def self.search(search)
        @articles = Article.where("concat_ws(' ', title, content) LIKE ?", "%" + search + "%")
    end
    
end
