# This is a Ruby class definition for an ArticlesController, which is a part of a Rails application.

class ArticlesController < ApplicationController
  # The index action retrieves a list of articles based on the search parameter.
  def index
    @articles = Article.search(params[:search])
  end

  # The show action retrieves and displays a specific article by its ID.
  def show
    @article = Article.find(params[:id])
  end

  # The new action initializes a new article object for creating a new article.
  def new
    @article = Article.new
  end

  # The create action attempts to save a new article and redirects to the article's show page if successful.
  # If the save is unsuccessful, it renders the new template with a status of unprocessable entity.
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # The edit action retrieves an existing article for editing.
  def edit
    @article = Article.find(params[:id])
  end

  # The update action attempts to update an existing article and redirects to the article's show page if successful.
  # If the update is unsuccessful, it renders the edit template with a status of unprocessable entity.
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # The destroy action deletes an article and redirects to the root path.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    # Private method to enforce strong parameters for the article.
    def article_params
      params.require(:article).permit(:title, :author, :content, :date, :search)
    end
end
