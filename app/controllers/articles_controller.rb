class ArticlesController < ApplicationController
  # allow cross-origin requests to crud endpoints while developing
  skip_before_action :verify_authenticity_token

  def index
    # return success message and all articles if request ok
    begin
      @articles = Article.all
      render json: {
        status: "success",
        message: "Articles fetched",
        data: { articles: @articles }
      }, status: :ok

    # otherwise return standard 500 error message
    rescue StandardError => e
      return_standard_error(e)
    end
  end

  def create
    # filter non-permitted params, attempt to create and save article, return success if valid
    begin
      @article = Article.new(article_params)
      @article.save
      render json: {
        status: "success",
        message: "Article successfully created",
        data: { article: @article }
      }, status: :ok

    # if passed attributes outside of permitted ones, return error 422
    rescue ActiveModel::ForbiddenAttributesError => e
      render json: {
        status: "error",
        error: { code: 422, message: e.message }
      }, status: :unprocessable_entity

    # otherwise return standard 500 error
    rescue StandardError => e
      return_standard_error(e)
    end
  end

  def update
    # find article by id, update params that pass permit check, return success if ok
    begin
      @article = Article.find(params[:id])
      @article.update(article_params)
      render json: {
        status: "success",
        message: "Article successfully updated",

      }, status: :ok

    # if no article has passed id, return a 404 error
    rescue ActiveRecord::RecordNotFound => e
      return_404_error(e)

    # otherwise return standard 500 error
    rescue StandardError => e
      return_standard_error(e)
    end
  end

  def destroy
    # find article by id in params, then destroy and return success if ok
    begin
      @article = Article.find(params[:id])
      @article.destroy
      render json: {
        status: "success",
        message: "Article successfully deleted"
      }, status: :ok

    # if no article with passed id return 404 message
    rescue ActiveRecord::RecordNotFound => e
      return_404_error(e)

    # otherwise return standard 500 error
    rescue StandardError => e
      return_standard_error(e)
    end
  end

  def show
    # find article by id and return it if ok
    begin
      @article = Article.find(params[:id])
      render json: {
        status: "success",
        message: "Article found",
        data: { article: @article }
      }, status: :ok

    # if no article with passed id return 404 message
    rescue ActiveRecord::RecordNotFound => e
      return_404_error(e)

    # otherwise return standard 500 error message
    rescue StandardError => e
      return_standard_error(e)
    end
  end

  def search_by_content
    # Find articles using query and search method
    begin
      @articles = Article.search(params[:query])
      render json: {
        status: "success",
        message: "Articles found",
        data: { article: @articles}
      }, status: :ok

    # return standard 500 error message if error occurs
    rescue StandardError => e
      return_standard_error(e)
    end
  end

  # param filtering stops danger from blind passing params to crud methods
  private
  def article_params
    params.permit(:content, :title, :date, :author)
  end

  # renders basic 404 error json
  private
  def return_404_error(e)
    render json: {
      status: "error",
      error: { code: 404, message: e.message }
    }, status: :not_found
  end

  # renders basic 500 error json
  private
  def return_standard_error(e)
    render json: {
      status: "error",
      error: { code: 500, message: e.message }
    }, status: :internal_server_error
  end
end
