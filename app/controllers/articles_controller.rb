class ArticlesController < ApplicationController
  # view and search articles
  def index
    @articles = Article.all

    if params[:article_search] && params[:article_search] != ""
      @articles = Article.search(params[:article_search])
    end
  end

  # get article by id
  def show
    @article = Article.find(params[:id])
  end
end
