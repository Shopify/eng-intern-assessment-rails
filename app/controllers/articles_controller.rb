class ArticlesController < ApplicationController
  # view all articles
  def index
    @articles = Article.all
  end

  # get article by id
  def show
    @article = Article.find(params[:id])
  end
end
