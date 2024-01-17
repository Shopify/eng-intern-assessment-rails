class ArticlesController < ApplicationController
  def index
    @articles = Article.all # Gets all the articles
  end

  def show
    @article = Article.find(params[:id]) # Gets the article with specific id
  end

  def new
    @article = Article.new # Creates a new article but doesnt save
  end

  def create
    # Initialize a new article with the inputed parameters
    @article = Article.new(article_params)

    if @article.save # Attempt to save the article
      redirect_to @article # Redirect to the saved article if sucessful
    else
      render :new, status: :unprocessable_entity # Show errors
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
