class ArticleController < ApplicationController
    def index
        @articles = Article.all
    end
end