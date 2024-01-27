class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :build_article, only: [:create]

  # Displays all articles or perform a search
  def index
    @articles = params[:clear_search] ? Article.all : Article.search(search_term)
  end

  # Displays a specific article
  def show; end

  # Initializes a new article
  def new
    @article = Article.new
  end

  # Creates and saves a new article
  def create
    if @article.save
      redirect_to articles_url, notice: 'Article was successfully created.'
    else
      handle_error_response(:new)
    end
  end

  # Modifies an existing article
  def update
    if @article.update(article_params)
      handle_successful_update
    else
      handle_error_response(:edit)
    end
  end

  # Fetches an article for editing
  def edit; end

  # Deletes an article
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  # Sets the article based on the ID provided
  def set_article
    @article = Article.find(params[:id])
  end

  # Builds a new article from the provided parameters
  def build_article
    @article = Article.new(article_params)
  end

  # Strong parameters for article creation and updating
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

  # Fetches the search term from the params
  def search_term
    params[:search].presence || ''
  end

  # Handles the response for a successful update
  def handle_successful_update
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@article, partial: "article", locals: { article: @article }) }
      format.html { redirect_to articles_url }
    end
  end

  # Handles error responses and renders appropriate views
  def handle_error_response(action)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update('error_messages', partial: 'shared/error_messages', locals: { errors: @article.errors.full_messages }) }
      format.html { render action, status: :unprocessable_entity }
    end
  end
end
