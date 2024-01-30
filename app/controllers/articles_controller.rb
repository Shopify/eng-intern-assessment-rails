# The ArticlesController is responsible for managing the lifecycle of articles in the application.
# It handles the standard CRUD operations: create, read, update, and delete.

class ArticlesController < ApplicationController
  # The 'index' action is responsible for listing all articles in the application.
  def index
    @articles = Article.search(params[:term])
  end

  # The 'show' action retrieves a single article by its ID and displays it.
  def show
    @article = Article.find(params[:id])
  end

  # The `new` action initializes a new, unsaved article for the form.
  def new
    @article = Article.new
  end

  # The `create` action attempts to save a new article to the database from the form data.
  def create
    @article = Article.new(article_params)

    # Set the article's date to the current time if it is not provided. This is to ensure that the article's date is always accurate.
if @article.date.nil?
    @article.date = Time.current
  end

  # If the article is successfully saved, redirect to the article's page. Otherwise, render the `new` template with the provided errors.
    if @article.save
      redirect_to articles_path, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # The 'edit' action retrieves an existing article by its ID for the form.
  def edit
    @article = Article.find(params[:id])
  end

  # The `update` action attempts to save changes to an existing article to the database from the form data.
  def update
    @article = Article.find(params[:id])

    # Set the article's date to the current time if it is not provided. This is to ensure that the article's date is always accurate.
    if @article.update(article_params)
      @article.update(date: Time.current)
      # If the article is successfully saved, redirect to the article's page. Otherwise, render the `edit` template with the provided errors.
      redirect_to @article, notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  #  The `destroy` action deletes an existing article by its ID from the database.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  # Strong Parameters: only allow the whitelisted parameters to be used to create/update an article.
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
