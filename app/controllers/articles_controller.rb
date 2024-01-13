# Handles HTTP requests related to articles with caching.

class ArticlesController < ApplicationController
  # Finds an article based on the ID parameter for the specified actions.
  before_action :set_article, only: [:show, :update, :destroy, :edit]

  # GET /articles
  # Fetches all articles from the database and assigns them to @articles.
  # Returns: HTML page displaying all articles.
  def index
    @articles = Rails.cache.fetch('articles', expires_in: 5.minutes) do
      Article.all
    end
  end

  # GET /articles/:id
  # Returns: HTML page displaying the article specified by the ID parameter.
  def show
    @article = Rails.cache.fetch(["article", params[:id]], expires_in: 5.minutes) do
      Article.find(params[:id])
    end
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
      Rails.cache.delete('articles')
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/:id
  # Attempts to update the article specified by the ID parameter with the parameters from the form submission.
  # Returns: Redirects to the article's page if successful, or re-renders the form with errors if unsuccessful.
  def update
    if @article.update(article_params)
      Rails.cache.delete(['article', @article.id])
      Rails.cache.delete('articles')
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/:id
  # Deletes the article specified by the ID parameter.
  # Returns: Redirects to the articles index page.
  def destroy
    if @article.destroy
      Rails.cache.delete(['article', @article.id])
      Rails.cache.delete('articles')
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