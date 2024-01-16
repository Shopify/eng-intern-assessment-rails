class ArticleController < ApplicationController
    def index
        @articles = Article.all
    end

    def show 
    end

    def new 
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article, notice: 'Article was successfully created'
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @article.update(article_params)
            redirect_to articles_url, notice: 'Article was successfully updated.'
        else
            render :edit
        end
    
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path, notice: 'Article was successfully destroyed'
    end

    def search
        @results = Article.search(params[:query])
    end

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end