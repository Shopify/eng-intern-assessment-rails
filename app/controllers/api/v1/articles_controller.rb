class Api::V1::ArticlesController < ApplicationController
  # Uncomment the line below when testing with Postman
  skip_before_action :verify_authenticity_token


  def index
    if Article.all.empty?
      render status: :no_content
    else
    render json: Article.all, status: :ok
    end
  end

  def show
    if Article.exists?(params[:id])
      render json: Article.find(params[:id]), status: :ok
    else
      render json:{error: "Requested article does not exist"}, status: :not_found
    end
  end

  def create
    article = Article.new(article_params)
    article.date = Date.today
    if article_params[:author].nil?
      article.author = "Anonymous"
    end
    if article.save
      render json: article, status: :created
    else
      render json: {message: "Failed to create article", errors: article.errors} , status: :unprocessable_entity
    end
  end

  def update
    article = Article.find_by(id: params[:id])

    if article&.update(article_params)
      render json: article, status: :ok
    else
      if article
        render json: {message: "Failed to update article", errors: article.errors} , status: :unprocessable_entity
      else
        render json: {message: "Article not found"}, status: :not_found
      end
    end
  end

  def destroy
    article = Article.find_by(id: params[:id])
    if article&.destroy
      render json: {message: "Article successfully deleted"}, status: :ok
    else
      render status: :not_found
    end
  end


  private 
  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
