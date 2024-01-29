class ArticlesController < ApplicationController
  before_action :find_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: "Article created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article updatedd"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_url, status: :see_other, notice: "Article deleted"
  end

  private
  # Find the article in question before running certain functions
  def find_article
    @article = Article.find(params[:id])
  end

  # Allows for selective permission of parameter assignment, allowing all for now
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
