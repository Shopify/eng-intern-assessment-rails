class ArticlesController < ApplicationController
  # GET /articles (index page)
  def index
    @articles = Article.all
  end

  # GET /articles/:id (Show article page)
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new (New Article page)
  def new
    @article = Article.new
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end