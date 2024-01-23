class ArticlesController < ApplicationController
    def index
        @articles = Article.all 
    end

    def new
        @article = Article.new()
        render "form"
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to root_path
        end
    end

    def show
        @article = Article.find(params[:id])
    end

    def edit
        @article = Article.find(params[:id])
        render "form"
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to article_path
        end
    end

    def destroy
        @article = Article.find(params[:id])
        if @article.destroy
            redirect_to articles_path
        end
    end

    private
        def article_params
            params.require(:article).permit(:title, :author, :content, :date)
        end
end
