class Api::V1::ArticlesController < ApplicationController
  def index
    # API will check to if database is empty, if so it will return a 204 status code
    if Article.all.empty?
      render status: :no_content
    else
    # If any articles are found, API will send all articles with a 200 status code  
    render json: Article.all, status: :ok
    end
  end

  def show
  end

  def create
    article = Article.new(article_params)

    if article.save
      render json: article, status: :created
    else
      render json: article.errors, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
  end


  private 
  def article_params
    params.require(:article).permit(:title, :body, :author)
  end
end
