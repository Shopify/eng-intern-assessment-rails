class ArticlesController < ApplicationController

    # GET /articles
    # Shows a list of all articles
    def index
      @articles = Article.all
    end
  
    # GET /articles/:id
    # Shows a specific article based on its id
    def show
      @article = Article.find(params[:id])
    end
  
    # GET /articles/new
    # Displays the form for creating a new article
    def new
      @article = Article.new
    end
  
    # GET /articles/:id/edit
    # Displays the form for editing an existing article
    def edit
      @article = Article.find(params[:id])
    end
  
    # POST /articles
    # Creates a new article
    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to @article
      else
        render 'new'
      end
    end
  
    # PATCH/PUT /articles/:id
    # Updates an existing article
    def update
      @article = Article.find(params[:id])
      if @article.update(article_params)
        redirect_to @article
      else
        render 'edit'
      end
    end
  
    # DELETE /articles/:id
    # Deletes a specific article
    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to articles_path
    end
  
    private
    # Strong parameters for article creation and update
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
    
  end