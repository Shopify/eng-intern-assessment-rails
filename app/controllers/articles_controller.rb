class ArticlesController < ApplicationController
  # before_action helps to avoid duplication of code to find the article in each relevant action
  before_action :current_article, only: [:show]

  def index
    # Fetch all articles from the database
    # Note: Consider pagination for performance in the future
    @articles = Article.all
  end

  def show
  end

  def current_article
    @article = Article.find(params[:id])
  end
end

