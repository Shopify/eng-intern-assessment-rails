class ArticlesController < ApplicationController
  # GET /articles or /articles.json
  # If there's a search parameter, filter the articles; otherwise, retrieve all articles.
  def index
    @articles = params[:search].present? ? Article.search(params[:search]) : Article.all
  end
  
  # GET /articles/:id
  # Retrieves a single article based on the id parameter.
  def show
    @article = Article.find(params[:id])
  end
  
  # GET /articles/new
  # Initializes a new article for the form helper.
  def new
    @article = Article.new
  end
  
  # POST /articles
  # Creates a new article from the form parameters.
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = 'New article created!'
      redirect_to @article
    else
      render 'new', status: :unprocessable_entity
    end
  end
  
  # GET /articles/:id/edit
  # Retrieves the article for editing based on the id parameter.
  def edit
    @article = Article.find(params[:id])
  end
  
  # PATCH/PUT /articles/:id
  # Updates an existing article with the provided parameters.
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = 'Article updated!'
      redirect_to @article
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  # DELETE /articles/:id
  # Deletes the specified article and redirects to the article list.
  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:success] = 'Article was successfully deleted.'
      redirect_to articles_path
    else
      flash[:alert] = 'Article could not be deleted.'
      redirect_to @article
    end
  end
  
  private
  
  # Only allow a list of trusted parameters through for an article.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
