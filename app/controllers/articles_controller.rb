# frozen_string_literal: true

# Manages all the CRUD operations, search and pagination for Article objects.
class ArticlesController < ApplicationController
  DEFAULT_ARTICLES_PER_PAGE = 5

  before_action :set_article, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # Retrieves articles with optional search and pagination
  def index
    @articles = Article.search(params[:search]).paginate(page: params[:page], per_page: DEFAULT_ARTICLES_PER_PAGE)
  end

  # Displays a single article
  def show
    # @article is set in set_article
  end

  # Initializes a new article
  def new
    @article = Article.new
  end

  # Creates a new article from the form submission
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Retrieves an article for editing
  def edit
    # @article is set in set_article
  end

  # Updates an article from the edit form submission
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes an article.
  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully destroyed.'
  end

  private

  # Finds an article by its id
  def set_article
    @article = Article.find(params[:id])
  end

  # Defines and sanitizes allowed params for article creation and update
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

  # Handles redirect for ActiveRecord::RecordNotFound exception
  def record_not_found
    redirect_to articles_path, alert: 'Article not found.'
  end
end
