class ArticlesController < ApplicationController
    def create
      @article = Article.create(article_params)
    end
  
    private
  
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
  end
  