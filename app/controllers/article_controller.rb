class ArticleController < ApplicationController
    # Display all articles
    def index
        @articles = Article.all
    end

    # Display a single article
    def show
    end

    # Create a new article
    def new
        @article = Article.new
    end

    # Create a new article based on the form data
    def create
        @article = Article.new(article_params)
        
        # Try to save the article
        if @article.save
            redirect_to @article, notice: 'Article was created successfully'  # Redirect to the article's page
        else
            render 'new'  # Render the new article form again
        end
    end

    private

    # Define the parameters that can be passed to the article
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end

    # Find the article to display
    def find_article
        @article = Article.find(params[:id])
    end
end