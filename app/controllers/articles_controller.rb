class ArticlesController < ApplicationController    
    
    # Displays a list of all articles
    def index
        # Displays search results if a search term is provided
        if params[:search].present?
            @articles = Article.search(params[:search])
            logger.debug "Search results: #{@articles.inspect}"
          else
            # Displays all articles if no search term is provided
            @articles = Article.all
          end
        # Redirects to the index view by default convention
    end

    # Displays a single article by ID
    def show
        @article = Article.find(params[:id])
    end

    # Loads a new article for creation
    def new 
        @article = Article.new
        # Redirects to the new view by default convention
    end

    # Creates a new article
    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article, notice: 'Article was successfully created.'
        else
            render :new
        end
    end

    # Loads an existing article for editing
    def edit
        @article = Article.find(params[:id])
        # Redirects to the edit view by default convention
    end

    # Handles the update of an existing article
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to @article, notice: 'Article was updated.'
        else
            render :edit
        end
    end

    # Destroys an article
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_url, notice: 'Article was successfully deleted.'
    end

    private 

    # Defines that only the following parameters are allowed to be passed to the controller
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end