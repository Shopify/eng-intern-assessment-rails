# The ArticlesController class is responsible for handling requests related to articles.
class ArticlesController < ApplicationController

  # Displays a list of articles based on the search query, if provided.
  # If no search query is provided, it displays all articles.
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # Displays the details of a specific article.
  def show
    @article = Article.find(params[:id])
  end

  # Initializes a new article object.
  # Creates a new article object.

  def new
    @article = Article.new
  end

  # Creates a new article with the provided parameters.
  # If the author is blank, it sets it to "Anonymous".
  # If the article is successfully saved, it redirects to the article's show page.
  # Otherwise, it renders the new article form with an unprocessable entity status.
  def create
    @article = Article.new(article_params)
    @article.date = Date.today

    if @article.author.blank?
      @article.author = "Anonymous"
    end

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Retrieves the article to be edited.
  def edit
    @article = Article.find(params[:id])
  end

  # Updates the article with the provided parameters.
  # If the author is blank, it sets it to "Anonymous".
  # If the article is successfully updated, it redirects to the article's show page.
  # Otherwise, it renders the edit article form with an unprocessable entity status.
  def update
    @article = Article.find(params[:id])
    @article.date = Date.today

    if @article.author.blank?
      @article.author = "Anonymous"
    end

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes the specified article.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  # Defines the permitted parameters for an article.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date, :search)
  end

end
