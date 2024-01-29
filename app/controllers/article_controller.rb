class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created
    else
      render json: @articles.errors, status: :unprocessable_entity
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      render json: @article, status: :ok
    else
      render json: @articles.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      head: :no_content
    else
      render json: @articles.errors, status: :unprocessable_entity

  end

  def search
    @articles = Article.search(params[:query])
    render json: @articles
  end

  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end