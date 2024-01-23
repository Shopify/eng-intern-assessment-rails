# Ruby on Rails controller for managing articles.
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # Retrieves all articles and renders the index view.
  def index
    @articles = Article.all
  end

  # Initializes a new article for creation.
  def new
    @article = Article.new
  end

  # Attempts to save a new article, redirects to the index if successful,
  # or re-renders the new form if there are errors.
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # Renders the article edit form.
  def edit
    render '_form'
  end

  # Attempts to update the article, redirects to the index if successful,
  # or re-renders the edit form if there are errors.
  def update
    if @article.update(article_params)
      redirect_to articles_path, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # Renders individual article details, handling the case where the article is not found with a custom 404 page.
  def show
    @article.nil? ? (render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false) : ( # Continue with the regular show action
      # ...
    )
  end

  # Deletes the specified article and redirects to the index.
  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully destroyed.'
  end

  # Searches for articles based on the provided query, rendering the index view.
  def search
    @articles = Article.search(params[:query])
    render :index, status: :see_other
  end

  private

  # Finds and sets the `@article` instance variable for actions requiring an article.
  def set_article
    @article = Article.find_by(id: params[:id])
  end

  # Defines permitted parameters for article creation and updating.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
