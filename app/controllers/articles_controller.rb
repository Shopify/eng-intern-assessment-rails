#   File: articles_controller.rb
#   Description: This file contains the ArticlesController class, which manages CRUD operations
#                for articles, including caching and claps functionality.

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :clap]

  # Fetch and paginate articles, caching the result for better performance.
  # Params: page - the page number
  def index
    @articles = Rails.cache.fetch("paginated_articles_#{params[:page]}", expires_in: 1.hour) do
      Article.paginate(page: params[:page], per_page: 2)
    end
  end
  
  # Fetch a single article by ID, caching the result for better performance.
  # Params: id - the ID of the article
  def show
    @article = Rails.cache.fetch("article_#{params[:id]}", expires_in: 1.hour) do
      Article.find(params[:id])
    end
  end

  # Initialize a new article with the current date.
  def new
    @article = Article.new
    @article.date = Date.today # Set the date to the current time
  end

  # Create a new article, clearing cache for specific page
  def create
    @article = Article.new(article_params.merge(claps: 0))

    if @article.save
      # Clear the cache relevant to the new article creation for the current page
      clear_paginated_articles_cache(params[:page])

      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  
  # Render the edit view for an existing article.
  def edit
  end

  # Update an existing article.
  def update
    if @article.update(article_params)
      # Clear the cache relevant to the updated article for the current page
      clear_paginated_articles_cache(params[:page])

      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  
  # Delete an article, removing it from the cache before destroying it.
  def destroy
    Rails.cache.delete("article_#{params[:id]}") # Remove the article from the cache before destroying it
    @article.destroy
    redirect_to root_path, notice: 'Article was successfully destroyed.'
  end
  
  # Search for articles based on a query.
  def search
    @articles = params[:query].present? ? Article.search(params[:query]) : Article.all
    render :search
  end
  
  # Increment claps for an article and redirect to the article page.
  def clap
    @article.increment!(:claps)
    redirect_to article_path(@article), notice: 'You clapped for the article!'
  end

  private

  # Set the @article instance variable based on the ID parameter.
  def set_article
    @article = Article.find(params[:id])
  end

  # Clear the cache for a given page
  def clear_paginated_articles_cache(page)
    # Clear the cache for the specific page, if not provided, then all
    Rails.cache.delete_matched("paginated_articles_#{page || '*'}")
  end
  # Define permitted parameters for article creation and updating.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
