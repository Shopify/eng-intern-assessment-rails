class ArticlesController < ApplicationController
  # View all articles
  def index
    @articles = Article.all
  end

  # View a single article
  def show
    @article = Article.find(params[:id])
  end
 
  # View the new article form
  def new
    @article = Article.new
  end

  # View the edit article form
  def edit
    @article = Article.find(params[:id])
  end

  # Create a new article
  def create
    @article = Article.create(article_params)
    @article.save
    redirect_to root_path
  end

  # Update the article
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to root_path
  end

  # Delete the article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, notice: "Article deleted successfully."
  end

  # Search for articles
  def search
    key = "%#{params[:key]}%"
    @articles = Article.search(params[:key])
    render 'search'
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end

