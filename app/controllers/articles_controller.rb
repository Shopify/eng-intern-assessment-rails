class ArticlesController < ApplicationController
  def index
    # Fetch all articles from the database
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
end
