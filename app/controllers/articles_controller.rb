# frozen_string_literal: true

class ArticlesController < ApplicationController
  # Displays a list of all articles.
  def index
    @articles = if params[:query].present?
                  Article.search(params[:query])
                else
                  Article.all
                end
  end

  # Show article based on specific parameter
  def show
    @article = Article.find(params[:id])
  end

  # Initializes a new article for the creation form
  def new
    @article = Article.new
  end

  # Create a new article based on form submission
  def create
    @article = Article.new(article_params)
    # Redirects to the show page if successful, or re-renders the new form if not
    if @article.save
      redirect_to @article, notice: I18n.t('article_controller.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Fetch an existing article for editing
  def edit
    @article = Article.find(params[:id])
  end

  # Updates an existing article based on form submission
  def update
    @article = Article.find(params[:id])
    # Redirects to the show page if successful, or re-renders the new form if not
    if @article.update(article_params)
      redirect_to @article, notice: I18n.t('article_controller.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes an article and redirects to the articles index page
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, status: :see_other, notice: I18n.t('article_controller.destroyed')
  end

  private

  # Only allow a list of trusted parameters through.
  # Helps prevent mass assignment vulnerabilities.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
