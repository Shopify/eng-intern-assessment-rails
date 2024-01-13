# Controller for managing articles.
class ArticlesController < ApplicationController
    # View all articles.
    def index
        @articles = Article.all
        Rails.logger.info("Viewing all articles")
    end
  
    # Display (Read) individual articles.
    #
    # @param id [Integer] The ID of the article to be displayed.
    def show
        @article = Article.find(params[:id])
        Rails.logger.info("Reading article with ID: #{params[:id]}")
    end
  
    # Create a new article.
    def new
        @article = Article.new
    end
  
    # Create a new article.
    #
    # @param article [Article] The article to be created.
    def create
        @article = Article.new(article_params)
        if @article.save
            Rails.logger.info("Created new article with ID: #{@article.id}")
            redirect_to @article
        else
            log_article_errors
            render 'new'
        end
    end
  
    # Edit an existing article.
    #
    # @param id [Integer] The ID of the article to be edited.
    def edit
        @article = Article.find(params[:id])
    end
  
    # Update an existing article.
    #
    # @param id [Integer] The ID of the article to be updated.
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            Rails.logger.info("Updating article with ID: #{params[:id]}")
            redirect_to @article
        else
            log_article_errors
            render 'edit'
        end
    end
  
    # Delete an article.
    #
    # @param id [Integer] The ID of the article to be deleted.
    def destroy
        @article = Article.find(params[:id])
        Rails.logger.info("Deleting article with ID: #{params[:id]}")
        @article.destroy
        redirect_to articles_path
    end
  
    # Search for articles based on a keyword.
    def search
        key = "%#{params[:key]}%"
        Rails.logger.info("Searching with key: #{key}")
        @articles = Article.where("title LIKE ?", key)
                        .or(Article.where("author LIKE ?", key))
                        .or(Article.where("content LIKE ?", key))
    end
  
    private
  
    # Strong parameters for article creation and update.
    def article_params
        if params[:article][:date].blank?
            params[:article][:date] = Date.today
        end
  
        if params[:article][:author].blank?
            params[:article][:author] = "unknown"
        end
  
        params.require(:article).permit(:title, :content, :author, :date)
    end
  
    # Log errors associated with article save/edit.
    def log_article_errors
        if @article.errors.any?
            Rails.logger.error("Article save/edit failed with errors:")
            @article.errors.full_messages.each do |msg|
            Rails.logger.error(" - #{msg}")
            end
        end
    end
end