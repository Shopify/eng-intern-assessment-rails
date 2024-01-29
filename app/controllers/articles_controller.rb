class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @articles = Article.find(params[:id])
  end
end
