class ArticlesController < ApplicationController

    # GET: /articles
    def index
        @articles = Article.all
    end

    # GET: /articles/:id
    def show
        @article = Article.find(params[:id])
      end

    # GET: /articles/new
    def new
        @article = Article.new
    end

    # POST: /articles
    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article, notice: 'Article was created.'
        else
            render 'new', notice: 'Article was not created.'
        end
    end

    # GET: /articles/:id/edit
    def edit
        @article = Article.find(params[:id])
    end

    # PUT: /articles/:id
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to @article, notice: 'Article was updated.'
        else
            render 'edit', notice: 'Article was not updated.'
        end
    end

    # DELETE: /articles/:id
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path, notice: 'Article was deleted.'
    end

    private

    # parameters for article
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end


    
