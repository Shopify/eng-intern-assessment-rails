class ArticlesController < ApplicationController

    # Makes sure the article is set for the show, edit, update, and destroy actions.
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    
    # Displays either all the articles or just the ones that match the search query.
    def index
        if params[:query].present?
            @articles = Article.search(params[:query])
        else
            @articles = Article.all
        end
    end
    
    # Displays the single article.
    def show
    end

    # Generates the editing form for an already existing article.
    def edit
    end
    
    # Manages the submission of the form to update an article.
    def update
        if @article.update(article_params)
            redirect_to @article, notice: 'Article successfully updated.'
        else
            render :edit
        end
    end

    # Deletes the specified article and then redirect to articles list.
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path, notice: 'Article successfully destroyed.'
    end

    # Generates the form for creating a new article.
    def new
        @article = Article.new
    end
    
    # Manages the submission of the form when creating a new article.
    def create
        @article = Article.new(article_params)
        # Save the new article to the database.
        if @article.save
            redirect_to @article, notice: 'Article successfully created.'
        else
            render :new
        end
    end
    
    private
        # Retrieves article based on its id provided in the parameters.
        def set_article
            @article = Article.find(params[:id])
        end
        
        # Strong parameters for article.
        def article_params
            params.require(:article).permit(:title, :content, :author, :date)
        end
end
