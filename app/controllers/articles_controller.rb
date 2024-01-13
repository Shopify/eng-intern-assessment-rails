class ArticlesController < ApplicationController
    # View all articles 
    def index
        @articles = Article.all
        Rails.logger.info("Viewing all articles")
    end

    # Display(Read) indivdual articles
    def show
        @article = Article.find(params[:id])
        Rails.logger.info("Reading article with ID: #{params[:id]}")
    end

    def new
        @article = Article.new
    end

    # Create a new article
    def create
        @article = Article.new(article_params)
        if (@article.save)
            Rails.logger.info("Created new article with ID: #{@article.id}")
            redirect_to @article
        else
            log_article_errors
            render 'new'
        end
    end

    def edit 
        @article = Article.find(params[:id])
    end

    # Update exisiting articles
    def update 
        @article = Article.find(params[:id])
        if (@article.update(article_params))
            Rails.logger.info("Updating article with ID: #{params[:id]}")
            redirect_to @article
        else
            log_article_errors
            render 'edit'
        end
    end

    # Delete articles
    def destroy 
        @article = Article.find(params[:id])
        Rails.logger.info("Deleting article with ID: #{params[:id]}")
        @article.destroy
        redirect_to articles_path
    end

    def search
        key = "%#{params[:key]}%"
        Rails.logger.info("Searching with key: @key")
        @articles = Article.where("title LIKE ?", key)
                          .or(Article.where("author LIKE ?", key))
                          .or(Article.where("content LIKE ?", key))
    end
      

    private

    def article_params
        # Check if the 'date' parameter is present in the form data and set default to today's date if not
        if params[:article][:date].blank?
            params[:article][:date] = Date.today
        end

        if params[:article][:author].blank?
            params[:article][:author] = "unknown"
        end
    
        params.require(:article).permit(:title, :content, :author, :date)
    end

    def log_article_errors
        if @article.errors.any?
          Rails.logger.error("Article save/edit failed with errors:")
          @article.errors.full_messages.each do |msg|
            Rails.logger.error(" - #{msg}")
          end
        end
      end
    
end
