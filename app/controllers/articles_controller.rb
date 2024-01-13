# Handles HTTP requests related to articles.
class ArticlesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  # Finds an article based on the ID parameter for the specified actions.
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  # Fetches all articles from the database and assigns them to @articles.
  # Returns: HTML page displaying all articles.
  def index
    @articles = Article.all
  end

  # GET /articles/:id
  # Returns: HTML page displaying the article specified by the ID parameter.
  def show
  end

  # GET /articles/new
  # Initializes a new, unsaved article and assigns it to @article.
  # Returns: HTML form for creating a new article.
  def new
    @article = Article.new
  end

  # GET /articles/:id/edit
  # Returns: HTML form for editing the article specified by the ID parameter.
  def edit
  end

  # POST /articles
  # Attempts to create a new article with the parameters from the form submission.
  # Returns: Redirects to the new article's page if successful, or re-renders the form with errors if unsuccessful.
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/:id
  # Attempts to update the article specified by the ID parameter with the parameters from the form submission.
  # Returns: Redirects to the article's page if successful, or re-renders the form with errors if unsuccessful.
  def update
    begin
      if @article.update(article_params) 
        redirect_to @article, notice: 'Article was successfully updated.'
      else
        render :edit
      end
    rescue => e
      flash[:error] = "There was an error updating the article: #{e.message}"
      render :edit
    end
  end

  # DELETE /articles/:id
  # Deletes the article specified by the ID parameter.
  # Returns: Redirects to the articles index page.
  def destroy
    if @article.destroy
      redirect_to articles_url, notice: 'Article was successfully destroyed.'
    else
      redirect_to articles_url, notice: 'Article could not be destroyed.'
    end
  end

  private

  # Sets @article based on ID parameter.
  def set_article
    @article = Article.find(params[:id])
  end

  # Defines allowed parameters for article.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end