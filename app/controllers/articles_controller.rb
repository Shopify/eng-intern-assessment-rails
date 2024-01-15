class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
  
    def index
        @articles = params[:query].present? ? Article.search(params[:query]) : Article.all
    end
  
    def show
        @article = Article.find(params[:id])
    end
  
    def new
      @article = Article.new
    end
  
    def create
      @article = Article.new(article_params)
  
      if @article.save
        redirect_to @article
      else
        render :new
      end
    end
  
    def edit
        @article = Article.find(params[:id])
    end
  
    def update
      if @article.update(article_params)
        redirect_to @article
      else
        render :edit
      end
    end
  
    def destroy
      @article.destroy
      redirect_to articles_path
    end
  
    private
  
    def set_article
      @article = Article.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
  end
  