class ArticlesController < ApplicationController
  
  # Displays all articles or performs a search
  def index
        if params[:search]
        
              @articles = Article.search(params[:search])   
        else
            @articles = Article.all
        end
  end
  
  
    # This returns a single article.
  def show
        @article = Article.find_by(id: params[:id])
        if @article.nil?
          redirect_to articles_path, alert: 'Article not found.'
        end
  end
  
   
   # This action will show a form to create a new article.
  def new
    @article = Article.new
  end
  
   # Creates and saves a new article
  def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to @article, notice: 'Article was successfully created.'
      else
            render :new, status: :unprocessable_entity
      end
  end
    
  
    # Returns an article for editing
  def edit
      @article = Article.find(params[:id])
      if @article.nil?
          redirect_to articles_path, alert: 'Article not found.'
      end
  end

    # Updates an Article
    def update
      @article = Article.find_by(id: params[:id])
        if @article.update(article_params)
          redirect_to @article, notice: 'Article was successfully updated.'
        else
          render :edit, status: :unprocessable_entity 
        end
      end
    
  
    # Deletes an article
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