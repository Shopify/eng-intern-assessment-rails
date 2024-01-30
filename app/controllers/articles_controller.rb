class ArticlesController < ApplicationController
  # Ensures that the set_article method is called before the specified actions
  before_action :set_article, only: %i[show edit update destroy]

  # Displays a list of articles, filtered by title if a query parameter is present
  def index
    if params[:query].present?
      @articles = Article.where("title LIKE ?", params[:query])
    else
      @articles = Article.all
    end
  end

  # Displays the details of a specific article
  def show
  end

  # Initializes a new article instance for creation
  def new
    @article = Article.new
  end

  # Renders the form for editing an existing article
  def edit
  end

  # Creates a new article based on parameters, and renders turbo_stream if successful
  def create
    @article = Article.new(article_params)
    if @article.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Updates an existing article with the provided parameters, redirects on success
  def update
    if @article.update(article_params)
      respond_to do |format|
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
      end
    else
      format.html { render :edit, status: :unprocessable_entity }
    end
  end

  # Destroys the specified article instance, rendering turbo_stream
  def destroy
    @article.destroy!

    respond_to do |format|
      format.turbo_stream
    end
  end

  private
    # Sets the @article instance variable based on the provided ID parameter
    def set_article
      @article = Article.find(params[:id])
    end

    # Defines the permitted parameters for article creation and updates
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
