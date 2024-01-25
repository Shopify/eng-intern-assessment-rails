class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :article_does_not_exist

  # GET /articles
  # Index action which shows all articles
  def index
    @articles = Article.all
  end

  # GET /articles/:id
  # Shows a specific article
  def show
    # @article is set by before_action
  end

  # GET /articles/new
  # Shows form for article creation
  def new
    @article= Article.new
  end

  # POST /articles
  # Handles article creation, redirects to article show page on success
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice:"Article created successfully!"
    else
      flash.now[:alert] = "Error creating article: " + @article.errors.full_messages.to_sentence
      render :new
    end
  end

  # GET /articles/:id/edit
  # Shows form for updating specific article
  def edit
    # @article is set by before_action
  end

  # PATCH/PUT /articles/:id
  # Handles article update, redirects to article show page on success
  def update
    # @article is set by before_action
    if @article.update(article_params)
      redirect_to @article, notice:"Article updated successfully!"
    else
      flash.now[:alert] = "Error updating article: " + @article.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /articles/:id
  # Handles article deletion, redirects to articles index page on success or article show page on failure
  def destroy
    # @article is set by before_action
    if @article.destroy
      redirect_to articles_path, notice: "Article deleted successfully!"
    else
      redirect_to @article, alert: "Error deleting article."
    end
  end

  private

  # Set the @article instance variable for all methods that find an article by its ID
  def set_article
    @article = Article.find_by(id: params[:id])
    if @article.nil?
      redirect_to articles_path, alert: "Article does not exist."
    end
  end

  # Strong parameter validation for all article fields
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end    

  # Redirects to articles index page if article does not exist
  def article_does_not_exist
    redirect_to articles_path, alert: "Article does not exist."
  end
end
