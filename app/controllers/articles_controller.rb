class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show #implement error handling if article not found?
    @article = Article.find(params[:id])
  end

  def new #implement error handling if article not found?
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.date = Date.today

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
