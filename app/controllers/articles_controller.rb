class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  # show a single article
  def show
    @article = Article.find(params[:id])
  end
end
