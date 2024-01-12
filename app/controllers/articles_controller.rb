# ArticlesController
#
# Handles all CRUD web requests related to Articles.
#
# Actions:
#   - index: Displays a list of all articles.
#   - show: Shows a single article, identified by its ID.
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
    if params[:search].present?
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # GET /articles/:id
  # Show action to render a specific article. Ruby implicitly understands that it needs to render view
  # corresponding to action, hence why it is empty. (DRY Principle)
  def show
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
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/:id/edit
  # Edit action to render the edit form for a specific article
  def edit
  end

  # PATCH/PUT /articles/:id
  # Update action to update a specific article
  # Redirects to the article's show page on success or re-renders 'edit' on failure
  def update
    if @article.update(article_params)
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
