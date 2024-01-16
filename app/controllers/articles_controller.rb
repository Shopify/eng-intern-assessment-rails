class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def find
    @article = Article.find(params[:id])
  end
end
