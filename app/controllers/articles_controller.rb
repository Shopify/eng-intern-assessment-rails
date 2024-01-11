class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  # new will be used to instantiate a new article for our form
  def new
    @article = Article.new
  end
  def create
    @article = Article.new(title: "...", body: "...")

    if @article.save
      # redirect to the get route for the article
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
end
