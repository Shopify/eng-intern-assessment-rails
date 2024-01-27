class ArticlesController < ApplicationController
  # Index action to list all articles
  def index
    @articles = Article.all
  end

  # Show action to display a specific article
  def show
    @article = Article.find(params[:id])
  end

  # New action to render a form for creating a new article
  def new
    @article = Article.new
  end

  # Edit action to render a form for editing an existing article
  def edit
    @article = Article.find(params[:id])
  end

  # Create action to handle the POST request from the new article form
  # Attempts to save the new article to the database
  def create
    @article = Article.new(article_params)

    if @article.save
      # Redirects to the article's show page if successful
      redirect_to @article
    else
      # Re-renders the 'new' form with error messages if save fails
      render :new, status: :unprocessable_entity
    end
  end

  # Update action to handle the PATCH/PUT request from the edit article form
  # Attempts to update the existing article in the database
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      # Redirects to the article's show page if successful
      redirect_to @article
    else
      # Re-renders the 'edit' form with error messages if update fails
      render :edit, status: :unprocessable_entity
    end
  end

  # Destroy action to handle the deletion of an article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    # Redirects to the root path after successful deletion
    redirect_to root_path, status: :see_other
  end

  private
  # Private method to whitelist allowed parameters for articles
  def article_params
    params.require(:article).permit(:title, :content)
  end
end