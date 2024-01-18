class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index #index route provides search functionality
    @articles = Article.search(params[:search])
  end

  def show #handled by before action
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.date = Date.today #automatically date stamp articles created through the web app

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit #handled by before action
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to root_path, status: :see_other
  end

  private

  def set_article
    begin
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to root_path
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
