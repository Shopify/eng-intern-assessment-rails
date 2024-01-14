class ArticlesController < ApplicationController
  # before_action helps to avoid duplication of code to find the article in each relevant action
  before_action :current_article, only: [:show, :edit, :update, :destroy]

  # GET /articles or GET /
  # Display a list of articles, optionally filtered by search.
  def index
    if params[:search].present?
      # If a search param is present, perform the search
      @articles = Article.search(params[:search])
    else
      # If no search param, fetch all articles from the database
      # Note: Consider pagination for performance in the future
      @articles = Article.all
    end
  end

  # GET /articles/:id
  # Show the details of a specific article
  def show
  end

  # GET /articles/new
  # Render a form for creating a new article.
  def new
    @article = Article.new
  end

  # POST /articles
  # Create a new article based on the article form values.
  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = "The Article was successfully  created!"
      redirect_to @article
    else
      flash[:alert] = "Failed to create the article."
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/:id/edit
  # Render a form for editing an existing article.
  def edit
  end

  # PATCH /articles/:id
  # Update an existing article based on the updated article data.
  def update
    if @article.update(article_params)
      flash[:notice] = "The Article was successfully  edited!"
      redirect_to @article
    else
      flash[:alert] = "Failed to update the article."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  # Delete an existing article
  def destroy
    if @article.destroy
      flash[:notice] = "Article was successfully deleted."
    else
      flash[:alert] = "Failed to delete the article."
    end

    redirect_to root_path, status: :see_other
  end

  private

    # Set the @article instance variable based on the article ID parameter.
    # If the article is not found, rescue ActiveRecord::RecordNotFound,
    # set a flash alert message to inform the user, and redirect to the articles index page.
    def current_article
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Article not found'
      redirect_to articles_path
    end

    # Allow specified parameters for article creation and update.
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end

