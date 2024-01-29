class ArticlesController < ApplicationController
  # finds article using find_article method
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  
  def index
    # lists all articles, ordered by date
    @articles = Article.search(params[:search])
  end
  
  def show
    # displays article details
    @article = Article.find(params[:id])
  end
  
  def new
    # initiates a new record for a new article
    @article = Article.new
  end
  
  def create
    # creates new article with parameters
    @article = Article.new(article_params)
    # loads show page if article created
    if @article.save
      redirect_to @article
    else
      # otherwise displays edit form
      render :new
    end
  end
  
  def update
    # updates article with parameters and loads article page
    if @article.update(article_params)
      redirect_to @article
    else
      # otherwise displays edit form
      render :edit
    end
  end
  
  def destroy
    # deletes article then loads index page 
    @article.destroy
    redirect_to articles_url
  end
  
  private
  
  def find_article
    # searches for article using ID
    @article = Article.find(params[:id])
  end
  
  def article_params
    # enforces acceptable parameters for articles
    params.require(:article).permit(:title, :content, :author, :date, :search)
  end

end