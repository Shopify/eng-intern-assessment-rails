#ArticlesController class inherits from ApplicationController
class ArticlesController < ApplicationController
    
    #callback called "set-article', executed before the 'show', 'edit', 'update', 'destroy' 
    # fetch the article based on the ":id" param
    before action :set_article, only: %i[show edit update destroy]


    #fetch all articles that assigns them to @article
    def index 
        @articles =Article.all
    end

    #fetches a single article using the set_article method
    def show
    end

    