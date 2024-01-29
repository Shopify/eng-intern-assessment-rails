class ArticlesController < ApplicationController
  # Display a list of all articles
  def index
    @articles = Article.all
  end

  # Display a single article
  def show
  end

  # Render a form to create a new article
  def new
    @article = Article.new
  end

  # Create a new article based on form submission
  def create
    @article = Article.new(article_params)
    
    # Attempt to save the article
    if @article.save
      #If the article is successfully saved, redirect to the show page with a success notice
      redirect_to @article, notice: 'Article was successfully created.'
    else
      # If there are errors, re-render the new article form
      render :new
    end
  end

  private

  # Define the permitted parameters for creating a new article
  def article_params
    params.require(:article).permit(:title, :content)
  end

  # Find the article before executing certain actions
  def find_article
    @article = Article.find(params[:id])
  end
end
