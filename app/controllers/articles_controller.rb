# The ArticlesController class is responsible for handling requests related to articles.
# It provides methods for displaying, creating, updating, deleting, and searching for articles.
class ArticlesController < ApplicationController
  # Retrieves all articles and assigns them to the @articles instance variable.
  def index
    @articles = Article.all
  end

  # Retrieves a specific article based on the provided ID and assigns it to the @article instance variable.
  def show
    @article = Article.find(params[:id])
  end

  # Initializes a new article object and assigns it to the @article instance variable.
  def new
    @article = Article.new
  end

  # Creates a new article based on the provided article_params and saves it to the database.
  # If the article is successfully saved, redirects to the show page of the created article.
  # Otherwise, renders the new template with a status of unprocessable_entity.
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Retrieves a specific article based on the provided ID and assigns it to the @article instance variable.
  def edit
    @article = Article.find(params[:id])
  end

  # Updates an existing article based on the provided article_params.
  # If the article is successfully updated, redirects to the show page of the updated article.
  # Otherwise, renders the edit template with a status of unprocessable_entity.
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes a specific article based on the provided ID.
  # After deletion, redirects to the root path with a status of see_other.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # Searches for articles based on the provided query and assigns the results to the @results instance variable.
  def search
    @results = Article.search(params[:query])
  end

  private
    # Strong parameters method that specifies the allowed attributes for creating/updating an article.
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
