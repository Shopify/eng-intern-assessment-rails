class ArticlesController < ApplicationController
  
  # List all articles
  def index
    @articles = Article.all
  end

  # Create a new article
  def new
    @article = Article.new
  end

  # Return an article by its id
  def show
    @article = Article.find(params[:id])
  end

  # Create a new article based on the given input
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Defines the parameters permitted for creating a new article
  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

end
