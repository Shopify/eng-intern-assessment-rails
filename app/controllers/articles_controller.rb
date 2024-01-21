class ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles, status: :ok
  end

  def show
    article = Article.find(params[:id])
    render json: article, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Article not found" }, status: :not_found
  end

  def create
    article = Article.new(article_params)
    if article.save
      render json: article, status: :created
    else
      render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    article = Article.find(params[:id])
    if article.update(article_params)
      render json: article, status: :ok
    else
      render json: {error: "Article not found"}, status: :not_found
    end
  end

  def destroy
    article = Article.find(params[:id])
    if article.destroy
      render json: { message: "Article successfully deleted" }, status: :ok
    else
      render json: { error: "Error deleting article" }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Article not found" }, status: :not_found
  end

  def article_params
    params.require(:article).permit(:title, :content, :author)
  end

  def search
    if params[:query].present?
      articles = Article.search(params[:query])
      render json: articles
    else
      render json: { error: "No such query found" }, status: :bad_request
    end
  end

end
