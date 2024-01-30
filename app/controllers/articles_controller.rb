class ArticlesController < ApplicationController
  # Ensures set_article method is called before specified actions to DRY up finding an article by ID
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # Lists all articles
  def index
    @articles = Article.all
  end

  # Shows a single article, @article is set by set_article method
  def show
  end

  # Initializes a new article instance for the 'new' form
  def new
    @article = Article.new
  end

  # Creates a new article from the form parameters
  def create
    @article = Article.new(article_params)
    if @article.save # If the article saves successfully
      redirect_to @article, notice: 'Article was successfully created.'
    else # If the article doesn't save due to validation failures
      render :new
    end
  end

  # Loads the article for editing, @article is set by set_article method
  def edit
  end

  # Updates the article with the form parameters
  def update
    if @article.update(article_params) # If the article updates successfully
      redirect_to @article, notice: 'Article was successfully updated.'
    else # If the update fails due to validation errors
      render :edit
    end
  end

  # Deletes the article
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    # Sets the @article instance variable from the ID in the parameters
    def set_article
      @article = Article.find(params[:id])
    end

    # Strong parameters: whitelists the parameters allowed for article creation/updating
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
