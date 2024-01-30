class ArticlesController < ApplicationController
  # Retrieves all articles from the database and assigns them to @articles.
  def index
    @articles = Article.all
  end

  # Retrieves a specific article from the database based on the provided ID and assigns it to @article.
  # Params:
  # - id: The ID of the article to retrieve.
  def show
    @article = Article.find(params[:id])
  end

  # Initializes a new instance of Article and assigns it to @article.
  def new
    @article = Article.new
  end

  # Creates a new article based on the provided parameters and saves it to the database.
  # If the article is successfully saved, redirects to the show page of the created article.
  # Otherwise, renders the new template with a status of :unprocessable_entity.
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Retrieves a specific article from the database based on the provided ID and assigns it to @article.
  # Params:
  # - id: The ID of the article to retrieve.
  def edit
    @article = Article.find(params[:id])
  end

  # Updates a specific article in the database based on the provided ID and parameters.
  # If the article is successfully updated, redirects to the show page of the updated article.
  # Otherwise, renders the edit template with a status of :unprocessable_entity.
  # Params:
  # - id: The ID of the article to update.
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes a specific article from the database based on the provided ID.
  # After deletion, redirects to the root path with a status of :see_other.
  # Params:
  # - id: The ID of the article to delete.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  # Strong parameters for article creation and update.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
