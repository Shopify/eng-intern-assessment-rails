class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
  
    # GET /articles
    def index
      @articles = Article.all
    end

    # Creates an instance for the form used in creating a new article
    def new
      @article = Article.new
    end
  
    # POST /articles
    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to @article
      else
        render :new
      end
    end
  
    # PATCH /articles/:id
    def update
      if @article.update(article_params)
        redirect_to @article
      else
        render :edit
      end
    end
  
    # DELETE /articles/:id
    def destroy
      @article.destroy
      redirect_to articles_path
    end
  
    # Searching for an article based on title or content
    def search
      @articles = Article.search(params[:search])
      render :index
    end
  
    private
      # To ensure the correct article is selected for any action
      def set_article
        @article = Article.find(params[:id])
      end
  
      # To ensure only correct params are passed into the model
      def article_params
        params.require(:article).permit(:title, :content, :author, :date)
      end
  end
  