class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  # GET /articles
  # Index action to render all articles
  def index
    @articles = Article.all
  end

  # GET /articles/:id
  # Show action to render a specific article
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
      render :new
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
