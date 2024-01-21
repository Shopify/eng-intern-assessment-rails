class ArticlesController < ApplicationController

  # Need this to test with Postman
  # REMOVE when done testing with Postman
  skip_before_action :verify_authenticity_token

  # GET /articles
  # Returns a list of all articles.
  def index
    articles = Article.all
    render json: articles, status: :ok
  end

  # GET /articles/:id
  # Returns a single article identified by its ID.
  # If the article is not found, returns a 404 Not Found response.
  def show
    article = Article.find(params[:id])
    render json: article, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Article not found" }, status: :not_found
  end

  # POST /articles
  # Creates a new article with the provided parameters.
  # If creation is successful, returns the created article and a 201 Created status.
  # If creation fails, returns the error message and a 422 Unprocessable Entity status.
  def create
    article = Article.new(article_params)
    article.date ||= Date.today
    if article.save
      render json: article, status: :created
    else
      render json: { errors: "There was an error creating the article" }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/:id
  # Updates an existing article identified by its ID.
  # Returns the updated article if successful or an error message if the update fails.
  # If the article is not found, returns a 404 Not Found response.
  def update
    article = Article.find(params[:id])
    if article.update(article_params)
      render json: article, status: :ok
    else
      render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Article not found" }, status: :not_found
  end

  # DELETE /articles/:id
  # Deletes an article identified by its ID.
  # Returns a success message if deleted.
  # If the article is not found, returns a 404 Not Found response.
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

  # GET /articles/search
  # Searches for articles based on a query parameter.
  # Returns a list of articles matching the query.
  # If no query is provided, returns a 400 Bad Request response.
  def search
    if params[:query].present?
      articles = Article.search(params[:query])
      render json: articles
    else
      render json: { error: "No such query found" }, status: :bad_request
    end
  end

  # GET /articles/title
  # Searches for articles based on a title query parameter.
  # Returns a list of articles where the title matches the query.
  # If no query is provided, returns a 400 Bad Request response.
  def search_by_title
    if params[:query].present?
      articles = Article.title(params[:query])
      render json: articles
    else
      render json: { error: "No such query found" }, status: :bad_request
    end
  end

  # GET /articles/author
  # Searches for articles based on an author query parameter.
  # Returns a list of articles where the author matches the query.
  # If no query is provided, returns a 400 Bad Request response.
  def search_by_author
    if params[:query].present?
      articles = Article.author(params[:query])
      render json: articles
    else
      render json: { error: "No such query found" }, status: :bad_request
    end
  end

  # method to whitelist parameters allowed for article creation and updating.
  private
  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
