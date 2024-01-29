class ArticlesController < ApplicationController
  # Index page/root - show all articles
  def index
    # Get all articles to display
    @articles = Article.all
  end

  # Search function - search for similarities in article title or content
  def search
    if params[:search].blank?
      # If nothing was put into the search bar, nothing happens and stays on root path
      redirect_to root_path and return
    else
      # Use search function in Article class to search in the title or content
      @parameter = params[:search]
      @results = Article.search(@parameter)
    end
  end

  # Displays article
  def show
    # Find article by its database ID
    @article = Article.find(params[:id])
  end

  # Instantiates a new article, but doesn't save it - used to view when building the form
  def new
    @article = Article.new
  end

  # Instantiates a new article AND saves it if saved successfully
  def create
    @article = Article.new(article_params)

    if @article.save
      # New article saved properly, now redirects browser to new article's page at 'articles/#{@article.id}'
      redirect_to @article
    else
      # New article not saved properly, redisplays form with error messages
      render :new, status: :unprocessable_entity
    end
  end

  # Fetch article from database, stores it in @article to be used for form building
  def edit
    @article = Article.find(params[:id])
  end

  # Fetch article and actually updates if successful
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      # Update successful, now redirects browser to updated article's page
      redirect_to @article
    else
      # Update unsuccessful, redisplays form with error messages
      render :edit, status: :unprocessable_entity
    end
  end

  # Fetch an article and deletes it from the database
  def destroy
    @article = Article.find(params[:id])
    # Deletes article with destroy
    @article.destroy

    # Redirects browser to the root path (index)
    # Status code 303 See Other = redirects don't link to requested resource itself, redirect to another page
    redirect_to root_path, status: :see_other
  end

  # Extra - Strong parameters to ensure inputs are correct
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
