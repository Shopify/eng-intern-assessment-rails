# ArticlesController
#
# Handles all CRUD web requests related to Articles, caching the indexing (for searching) and the show actions.
#
# Actions:
#   - index: Displays a list of all articles.
#   - show: Shows a single article, identified by its ID. Checks cache first to see if existing already.
#   - new: Returns a form for creating a new article.
#   - create: Handles the creation of a new article.
#   - edit: Returns a form for editing an existing article.
#   - update: Handles the updating of an existing article.
#   - destroy: Handles the deletion of an existing article.
#
# Callbacks:
#   - set_article (before_action): A private method used as a callback to set
#     the @article instance variable before actions like show, edit, update, and destroy.
#
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  # GET /articles
  # Index action to render all articles
  def index
    # Generate a unique cache key for the index action, based on the maximum updated_at timestamp, and article amount.
    # This ensures that any change to an article will change the cache key, invalidating the old cache.
    # We don't need to modify any other methods to account for cache, since all cache keys will be unique.
    @articles = Rails.cache.fetch("articles_index/#{Article.count}-#{Article.maximum(:updated_at)}") do
      if params[:search].present?
        Article.search(params[:search])
      else
        Article.all
      end
    end
  end

  # GET /articles/:id
  # Show action to render a specific article.
  def show
    @article = Rails.cache.fetch("article_#{params[:id]}", expires_in: 1.hour) do
      Article.find(params[:id])
    end
  end

  # GET /articles/new
  # New action to render a new article form
  def new
    @article = Article.new
  end

  # POST /articles
  # Create action to create a new article
  # Redirects to the article's show page on success or re-renders 'new' on failure
  def create
    @article = Article.new(article_params)
    if @article.save
      Rails.cache.delete_matched("article_*")
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/:id/edit
  # Edit action to render the edit form for a specific article. Ruby implicitly understands that it needs to render
  # corresponding to action, hence why the rest of it is empty. (DRY Principle)
  def edit
  end

  # PATCH/PUT /articles/:id
  # Update action to update a specific article
  # Redirects to the article's show page on success or re-renders 'edit' on failure
  def update
    if @article.update(article_params)
      Rails.cache.delete("article_#{params[:id]}")
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/:id
  # Destroy action to delete a specific article
  # Redirects to articles index on success, with a notice or alert on failure
  def destroy
    if @article.destroy
      redirect_to articles_path, notice: 'Article was successfully destroyed.'
    else
      redirect_to articles_path, alert: 'Article could not be deleted.'
    end
  end

  private

  # Set_article to find an article by id
  # Used as a before action for show, edit, update, and destroy actions
  def set_article
    @article = Article.find(params[:id])
  end

  # Strong parameters for creating/updating articles
  # Permits title, content, author, and date
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
