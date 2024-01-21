class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def index
    # Allow searching 
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  def show
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end
end
