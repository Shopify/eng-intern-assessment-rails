class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
  
    def index
      # Trigger search method if a parameter is provided
      if params[:search]
        @articles = Article.search(params[:search])
      # Default to search all
      else
        @articles = Article.all
      end
    end
  
    def show
    end

    def new
      @article = Article.new
    end
    
  
    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to @article, notice: 'Article was successfully created.'
      else
        render turbo_stream: turbo_stream.replace('article_form', partial: 'form', locals: { article: @article })
      end
    end
  
    def edit
    end
  
    def update
      if @article.update(article_params)
        redirect_to @article, notice: 'Article updated successfully .'
      else
        render :edit
      end
    end
  
    def destroy
      @article.destroy
      redirect_to articles_url, notice: 'Article destroyed successfully.'
    end
  
    private
      def set_article
        @article = Article.find(params[:id])
      end
  
      def article_params
        params.require(:article).permit(:title, :content, :author, :date)
      end
  end
  