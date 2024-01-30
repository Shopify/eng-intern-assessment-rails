class ArticlesController < ApplicationController
  # Displays a list of all articles
  def index
    @articles = Article.all
  end

  # Shows details of a specific article identified by params[:id]
  def show
    @article = Article.find(params[:id])
  end

  # Prepares a new, unsaved article for creation
  def new
    @article = Article.new
  end

  # Creates a new article from parameters and redirects on success
  # On failure (e.g., validation errors), it re-renders the 'new' view for correction
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  # Fetches the article for editing
  def edit
    @article = Article.find(params[:id])
  end

  # Updates the article and redirects on success
  # On failure, re-renders the 'edit' view for correction
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  # Deletes the article and redirects to the list of articles
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  # Strong parameters method for creating/updating articles
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
