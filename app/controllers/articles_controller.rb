# The ArticlesController class handles the logic for managing articles in the application using CRUD operations
# The ArticlesController class handles the CRUD operations for articles.
class ArticlesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # If the 'search' parameter is present, it performs a search using the Article model's search method.
    # Otherwise, it retrieves all articles.
    # GET /articles/
    def index
        if params[:search].present?
            @articles = Article.search(params[:search])
        else
            @articles = Article.all
        end
    end

    # Retrieves the article with the specified ID
    # GET /articles/:id
    def show
        @article = Article.find(params[:id])
    end

    # Initializes a new article object
    # GET /articles/new
    def new
        @article = Article.new
    end

    # Creates a new article with the provided parameters
    # If the article is successfully saved, it redirects to the article's show page
    # If there are validation errors, it renders the new article form again
    # POST /articles/
    def create
        @article = Article.new(article_params)

        if @article.save
            flash[:notice] = 'Article was successfully created.'
            redirect_to @article
        else
            render :new
        end
    end

    # Retrieves the article with the specified ID and assigns it to the instance variable @article
    # GET /articles/:id/edit
    def edit
        @article = Article.find(params[:id])
    end

    # Updates an article with the given parameters.
    # Redirects to the updated article if successful, otherwise renders the edit view.
    # PATCH /articles/:id
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:notice] = 'Article was successfully updated.'
            redirect_to @article
        else
            render :edit
        end
    end

    # Deletes an article from the database
    # DELETE /articles/:id
    def destroy
        @article = Article.find(params[:id])
        if @article.destroy
            flash[:notice] = 'Article was successfully deleted.'
            redirect_to articles_path
        else
            flash[:alert] = 'Article could not be deleted.'    
            redirect_to articles_path
        end
    end
    
    private
    
    # Defines the permitted parameters for an article
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end

    # Handles the case when an article is not found
    def record_not_found
        flash[:alert] = 'Article could not be found.'
        redirect_to articles_path
    end
end
