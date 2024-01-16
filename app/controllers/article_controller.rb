class ArticleController < ApplicationController
    # GET: Fetch 
    def index
        @articles = Article.all
    end
  
    # Default
    def show 
    end

    # Default
    def new 
    end

    # POST: create a new article 
    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article, notice: 'Article was successfully created'
        else
            render :new
        end
    end

    # Default
    def edit
    end

    # PUT: update a specified article
    def update
        if @article.update(article_params)
            redirect_to articles_url, notice: 'Article was successfully updated.'
        else
            render :edit
        end
   
    # Delete: delete a specified article
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path, notice: 'Article was successfully destroyed'
    end

    # GET: searches article that matches query parameters
    def search
        @results = Article.search(params[:query])
    end

    def set_article
        @article = Article.find(params[:id])
    end

    # Only looking for the below parameters
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end