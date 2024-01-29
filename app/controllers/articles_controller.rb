class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  # GET /articles
  # GET /articles?search=:term
  # If a search term is provided, returns articles that match the search term.
  # Otherwise, returns all articles, ordered by the updated_at field in descending order.
  def index
    @articles = if params[:search].present?
                  Article.search(params[:search])
                else
                  Article.order('updated_at DESC')
                end
  end

  # GET /articles/:id
  # Returns a single article identified by the id parameter.
  def show; end

  # GET /articles/new
  # Initializes a new, unsaved article.
  def new
    @article = Article.new
  end

  # POST /articles
  # Attempts to create a new article with the provided parameters. If successful, redirects to the articles index.
  # If unsuccessful, does nothing (validation and error handling to be added).
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path, notice: 'Article was successfully created.'
    else
      # TODO: Add validation and error handling.
    end
  end

  # GET /articles/:id/edit
  # Finds an article identified by the id parameter and prepares it for editing.
  def edit; end

  # PATCH/PUT /articles/:id
  # Attempts to update an article identified by the id parameter with the provided parameters.
  # If successful, redirects to the article's detail view. If unsuccessful, re-renders the edit view.
  def update
    if @article.update(article_params)
      redirect_to article_path, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/:id
  # Attempts to destroy an article identified by the id parameter. If successful, redirects to the articles index.
  # If unsuccessful, does nothing (error handling to be added).
  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
