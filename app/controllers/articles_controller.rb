class ArticlesController < ApplicationController
    # Displays a list of all articles
    def index
        @articles = Article.all
    end

    # Displays a single article
    def show
        @article = Article.find(params[:id])
    end

    # Initializes a new article instance
    def new 
        @article = Article.new
    end

    # Handles the creation of a new article
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

    # Strong parameters: only allow title and content for mass assignment
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end
