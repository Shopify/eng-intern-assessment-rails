class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  def search
    @articles = Article.search(params[:search])
  end
end
