class ArticlesController < ApplicationController
  def index
    @articles = Article.all

  def show
    @article = Article.find(params[:id])
  end
end
