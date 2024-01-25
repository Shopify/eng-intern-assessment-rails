# Controller for the Article model. It contains the CRUD actions for the Article model.
class ArticlesController < ApplicationController
  #Set up @article before certain actions are called for DRY purposes and efficiency.
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # Display all articles or filter articles by search query.
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # Show a specific article; redirect to index if article is not found.
  def show
    if @article.nil?
      redirect_to articles_path, notice: 'Article not found'
    end
  end

  def edit
  end

  # Update an existing article; redirect to edit if article is not updated successfully.
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @article = Article.new
  end

  # Create a new article; redirect to new if article is not created successfully.
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # Delete an existing article; redirect to index if article is deleted successfully.
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  # Set @article based on the provided ID.
  def set_article
    @article = Article.find(params[:id])
  end

  # Set the permitted parameters for an article.
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
