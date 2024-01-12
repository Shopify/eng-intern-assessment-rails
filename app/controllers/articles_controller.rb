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
    
    end

    # Create a new article
    def create
        @article = Article.new(article_params)
        @article.save
        redirect_to @article
    end

    
    private

    def article_params
        # Check if the 'date' parameter is present in the form data and set default to today's date if not
        if params[:article][:date].blank?
            params[:article][:date] = Date.today
        end
    
        params.require(:article).permit(:title, :content, :author, :date)
    end
end
