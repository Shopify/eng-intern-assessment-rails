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
    #                    2. only `articles_per_page` articles are caches at a time
    def index
        @articles = Rails.cache.fetch(['articles', articles_cache_key], expires_in: caching_time.minutes) do
          if params[:search].present?
            Article.search(params[:search]).paginate(page: params[:page], per_page: articles_per_page)
          else
            Article.paginate(page: params[:page], per_page: articles_per_page)
          end
        end
    end

    # Get /articles/:id
    # Fetches a single article based on the ID parameter from the cache or the database
    def show
        @articles = Rails.cache.fetch(['articles', articles_cache_key], expires_in: caching_time.minutes) do
          Article.find(params[:id])
        end
    rescue ActiveRecord::RecordNotFound
        # Handles the case where the article is not found
        redirect_to articles_url, alert: 'Article not found'
    end

    def new
        @article = Article.new
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