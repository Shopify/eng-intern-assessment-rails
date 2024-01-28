##########################################################################
# Purpose:  Class to handle HTTP requests related to the article class   #
# Author:   Aditya Goel (January 27, 2024)                               #
# Updated:  Aditya Goel (January 27, 2024)                               #
##########################################################################

class ArticleController < ApplicationController
    # Time to cache the data for (in minutes)
    $caching_time = 5
    # Number of articles on the page at a time
    $articles_per_page = 10

    before_action :set_article, only: [:show, :update, :destroy, :edit]

    # GET /articles
    # Fetches a paginated subset of articles based on a search query, if provided.
    # If no query, all articles are fetched. Results are cached for efficiency.
    # Chaching strategy: 1. articles are cached for `caching_time` minutes 
    #                    2. only `articles_per_page` articles are cached at a time
    def index
        @articles = Rails.cache.fetch(['articles', articles_cache_key], expires_in: caching_time.minutes) do
          if params[:search].present?
            Article.search(params[:search]).paginate(page: params[:page], per_page: articles_per_page)
          else
            Article.paginate(page: params[:page], per_page: articles_per_page)
          end
        end
    end

    # GET /articles/:id
    # Fetches a single article based on the ID parameter from the cache or the database
    def show
        @articles = Rails.cache.fetch(['articles', articles_cache_key], expires_in: caching_time.minutes) do
          Article.find(params[:id])
        end
    rescue ActiveRecord::RecordNotFound
        # Handles the case where the article is not found
        redirect_to articles_url, alert: 'Article not found'
    end

    # GET /articles/new
    # Initializes a new article
    def new
        @article = Article.new
    end

    # GET /articles/:id/edit
    # Fetches the article specific by the ID parameter to be editted
    def edit
    end

    # POST /articles
    # Creates a new article with the provided parameters.
    def create
        @article = Article.new(article_params)
        # Sets the date to today's date if no date is provided
        if @article.date.blank?
            @article.date = Date.today
        end

        # Sets the author to "Anonymous" if no author is provided
        if @article.author.blank?
            @article.author = "Anonymous"
        end

        if @article.save
            Rails.cache.delete('articles')
            redirect_to @article, notice: 'Article created successfully'
        else
            render :new, status: :unprocessable_entity
        end
    end

    # PUT /articles/:id
    # Updates the article with the specified ID parameter
    def update
        if @article.update(article_params)
            # Sets the date to today's date if no date is provided
            if @article.date.blank?
                @article.date = Date.today
            end

            # Sets the author to "Anonymous" if no author is provided
            if @article.author.blank?
                @article.author = "Anonymous"
            end

            Rails.cache.delete('articles')
            Rails.cache.delete(["article", @article.id])
            redirect_to @article, notice: 'Article updated successfully'
        else
            render :edit
        end
    end

    # DELETE /articles/:id
    # Deletes the article with the specified ID parameter
    def destroy
        @article.destroy
        Rails.cache.delete('articles')
        Rails.cache.delete(["article", @article.id])
        redirect_to articles_url, notice: 'Article deleted successfully'
    end

    private

    # Generates a dynamic cache key based on the current page and search query.
    def articles_cache_key
        [
          'articles',
          params[:page] || 1,
          params[:search],
        ].join('-')
    end

    # Sets article based on ID
    def set_article
        @article = Article.find(params[:id])
    end

    # Defines allowed parameters for article.
    def article_params
        params.require(:article).permit(:title, :content, :author, :date, :page)
    end
end