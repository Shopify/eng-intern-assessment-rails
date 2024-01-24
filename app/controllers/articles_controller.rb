class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    
    def index
        if params[:query].present?
            @articles = Article.search(params[:query])
        else
            @articles = Article.all
        end
    end
    
    def show
    end

    def edit
    end
    
    def update
        if @article.update(article_params)
            redirect_to @article, notice: 'Article successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path, notice: 'Article successfully destroyed.'
    end

    def new
        @article = Article.new
    end
    
    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article, notice: 'Article successfully created.'
        else
            render :new
        end
    end
    
    private
        def set_article
            @article = Article.find(params[:id])
        end
    
        def article_params
            params.require(:article).permit(:title, :content, :author, :date)
        end
end
