# The ArticlesController class is responsible for handling requests related to articles.
class ArticlesController < ApplicationController
    # Retrieves all articles from the database and assigns them to the @articles instance variable.
    def index 
        @articles = Article.all
    end

    # Retrieves a specific article from the database based on the provided ID and assigns it to the @article instance variable.
    def show 
        @article = Article.find(params[:id])
    end

    # Initializes a new instance of the Article model and assigns it to the @article instance variable.
    def new 
        @article = Article.new
    end

    # Creates a new article with the provided parameters and saves it to the database.
    # If the article is successfully saved, redirects to the show page of the created article.
    # Otherwise, renders the new page with a status of unprocessable entity.
    def create 
        @article = Article.create(article_params.merge(:date => Date.today))

        if @article.save
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
        end
    end

    # Updates an existing article with the provided parameters and saves it to the database.
    # If the article is successfully updated, redirects to the show page of the updated article.
    # Otherwise, renders the edit page with a status of unprocessable entity.
    def update
        @article = Article.find(params[:id])

        if @article.update(article_params.merge(:date => Date.today))
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # Retrieves an existing article from the database based on the provided ID and assigns it to the @article instance variable.
    def edit 
        @article = Article.find(params[:id])
    end

    # Deletes an existing article from the database based on the provided ID.
    # After deletion, redirects to the root path with a status of see other.
    def destroy 
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to root_path, status: :see_other
    end

    # Searches for articles based on the provided query and assigns the result to the @article instance variable.
    def search 
        @article = Article.search(params[:query])
    end

    private
        # Defines the permitted parameters for creating or updating an article.
        def article_params
            params.require(:article).permit(:title, :content, :author)
        end
end
