# Controller class for to handle /articles endpoints
class ArticlesController < ApplicationController
  # GET /articles
  def index
    @articles = Article.all
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/:id
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH /articles/:id
  # Redirects to the updated article page if update is successful, otherwise renders the edit page again
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  # Redirects to the root path if destroy is successful
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  # DELETE /articles/search/:query
  # Renders the root page with the search results
  def search
    @articles = Article.search(params[:query])
    render :index
  end

  private

  # Only allow a list of appropirate parameters
  def article_params
    params.require(:article).permit(:title, :content, :valid, :author, :date, :property)
  end
end
