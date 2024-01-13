# The ArticlesController class handles the logic for managing articles in the application
class ArticlesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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

    # Deletes an article from the database
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

    # Retrieves the article with the specified ID and assigns it to the instance variable @article.
    def edit
        @article = Article.find(params[:id])
    end

    # Updates an article with the given parameters.
    # Redirects to the updated article if successful, otherwise renders the edit view.
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:notice] = 'Article was successfully updated.'
            redirect_to @article
        else
            render :edit
        end
    end
    
    private
    
    def article_params
        params.require(:article).permit(:title, :content, :author)
    end

    def record_not_found
        flash[:alert] = 'Article not found.'
        redirect_to articles_path
    end

    private

    # Defines the permitted parameters for an article
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end
end
