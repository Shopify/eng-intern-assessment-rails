class ArticlesController < ApplicationController
    # View all articles 
    def index
        @articles = Article.all

    end

    # Display(Read) indivdual articles
    def show
        @article = Article.find(params[:id])

    end

    def new
        @article = Article.new
    end

    # Create a new article
    def create
        @article = Article.new(article_params)
        @article.save
        redirect_to @article
    end

    def edit 
        @article = Article.find(params[:id])
    end

    # Update exisiting articles
    def update 
        @article = Article.find(params[:id])
        @article.update(article_params)
        redirect_to @article
    end

    # Delete articles
    def destroy 
        @article = Article.find(params[:id])
        puts "Deleting article with ID: #{params[:id]}"

        @article.destroy

        redirect_to articles_path
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
end
