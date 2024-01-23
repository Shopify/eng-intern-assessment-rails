class ArticlesController < ApplicationController

    # Retrieves and displays a list of all articles.
    def index
        @articles = Article.all
    end
    
    # Displays a specific article based on the provided article ID.
    def show
        @article = Article.find(params[:id])
    end

    # Initializes a new article instance for the creation form.
    def new
        @article = Article.new
    end

    # Creates a new article with the specified attributes and saves it to the database.
    # Redirects to the article's show page if successful, or re-renders the new article form with errors if unsuccessful.
    def create
        @article = Article.new(title: "...", body: "...")

        if @article.save
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
        end
    end

    # Defines the permitted parameters for article creation and updating.
    private
        def article_params
            params.require(:article).permit(:title, :content, :author, :date)
        end

    # Prepares an existing article for editing by fetching it from the database based on the provided ID.
    def edit
        @article = Article.find(params[:id])
    end

    # Updates an existing article with the provided parameters.
    # Redirects to the article's show page if the update is successful, or re-renders the edit form with errors if unsuccessful.
    def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # Deletes the specified article from the database and redirects to the root path.
    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to root_path, status: :see_other
    end
end
