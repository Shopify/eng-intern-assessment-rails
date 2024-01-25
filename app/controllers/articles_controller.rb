class ArticlesController < ApplicationController
    # GET /articles
    # This action will show all articles or search for articles if search parameters are given.
    def index
      if params[:search]
        @articles = Article.search(params[:search])
      else
        @articles = Article.all
      end
    end
  
    # GET /articles/:id
    # This action will show a single article. If the article is not found, it will redirect to the articles index.
    def show
      @article = Article.find_by(id: params[:id])
      if @article.nil?
        redirect_to articles_path, alert: 'Article not found.'
      end
    end
  
    # GET /articles/new
    # This action will show a form to create a new article.
    def new
      @article = Article.new
    end
  
    # POST /articles
    # This action will handle the creation of the new article.
    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to @article, notice: 'Article was successfully created.'
      else
        render :new
      end
    end
  
    # GET /articles/:id/edit
    # This action will show a form to edit an existing article. If the article is not found, it will redirect to the articles index.
    def edit
      @article = Article.find_by(id: params[:id])
      if @article.nil?
        redirect_to articles_path, alert: 'Article not found.'
      end
    end
  
    # PATCH/PUT /articles/:id
    # This action will handle the update of the article.
    def update
      @article = Article.find_by(id: params[:id])
      if @article.update(article_params)
        redirect_to @article, notice: 'Article was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /articles/:id
    # This action will handle the deletion of the article.
    def destroy
      @article = Article.find_by(id: params[:id])
      @article.destroy
      redirect_to articles_url, notice: 'Article was successfully destroyed.'
    end
  
    private
      # Only allow a list of trusted parameters through.
      def article_params
        params.require(:article).permit(:title, :content, :author, :date)
      end
  end
  