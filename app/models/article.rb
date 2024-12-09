class Article < ApplicationRecord

    #search method added for Article class
    def self.search(search)
        @articles = Article.where("concat_ws(' ', title, content) LIKE ?", "%" + search + "%")
    end
end


# @articles = Article.where("concat_ws(' ', title, content) LIKE ?", "%" + params[:q].to_s + "%")