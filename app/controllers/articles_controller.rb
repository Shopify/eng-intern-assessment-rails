class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show #implement error handling if article not found?
    @article = Article.find(params[:id])
  end
end
