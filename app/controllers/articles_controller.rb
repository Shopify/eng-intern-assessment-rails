class ArticlesController < ApplicationController
  # Before executing the specified actions (show, edit, update, destroy),
  # set the @article instance variable using the set_article method.
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # Returns a JSON representation of all articles.
  def index
    if params[:query].present?
      @articles = Article.search(params[:query])
    else
      @articles = Article.all
    end
  end

  # GET /articles/count
  # Returns the count of all articles.
  def count
    @articles = Article.all
    render json: @articles.length
  end

  # GET /articles/1
  # Displays the details of a specific article.
  def show
    # This action does not have its own rendering logic as it relies on the default.
  end

  # GET /articles/new
  # Initializes a new article for creating.
  def new
    @article = Article.new
  end

  # POST /articles
  # Creates a new article based on the provided parameters.
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # GET /articles/1/edit
  # Initializes an existing article for editing.
  def edit
    # This action does not have its own rendering logic as it relies on the default.
  end

  # PATCH/PUT /articles/1
  # Updates the attributes of an existing article.
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  # Deletes an existing article.
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
