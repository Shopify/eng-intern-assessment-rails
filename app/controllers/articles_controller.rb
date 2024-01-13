# The ArticlesController class handles the logic for managing articles in the application
class ArticlesController < ApplicationController
    # Retrieves all articles from the database
    def index
        @articles = Article.all
    end

    # Initializes a new article object
    def new
        @article = Article.new
    end

    # Creates a new article with the provided parameters
    # If the article is successfully saved, it redirects to the article's show page
    # If there are validation errors, it renders the new article form again
    def create
        @article = Article.new(article_params)

        if @article.save
            redirect_to @article
        else
            render 'new'
        end
    end

    private

    # Defines the permitted parameters for an article
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end
end
