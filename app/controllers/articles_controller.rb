class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]


  # GET /articles
  # Index page for viewing paginated article list
  def index
    # The current page index
    @page = params.fetch(:page, 0).to_i

    # Number of articles loaded per page
    articles_per_page = 20
    page_offset = @page * articles_per_page

    # Flag indicating if all articles are being displayed
    @showing_all_articles = params[:query].present? ? false : true
  
    if params[:query].present?
      # If a search query is provided, use the search functionality with pagination
      @articles = Article.search(params[:query]).limit(articles_per_page).offset(page_offset)
      
      # The number of articles retrieved from the query
      @num_articles = Article.search(params[:query]).count
    else
      # If no query is provided, return all articles with pagination
      @articles = Article.order(title: :asc).limit(articles_per_page).offset(page_offset)

      # The total number of articles
      @num_articles = Article.count
    end

    # Calculations for the range of articles on the current page
    @start_index = @num_articles == 0 ? 0 : page_offset + 1
    @end_index = [page_offset + articles_per_page, @num_articles].min

    # Flag indicating if there are more articles beyond the current page index
    @more_results = @end_index < @num_articles
  end
    
  # GET /articles/new
  # New article form
  def new
    @article = Article.new
  end
  
  # POST /articles
  # Creates a new article using the given parameters
  # Redirects to the article page on success, or renders `new` to display errors on failure
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end
  
  # POST /articles/:id
  # Updates the given article using the given parameters
  # Redirects to the article page on success, or renders `edit` to display errors on failure
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end
  
  # DELETE /articles/:id
  # Deletes the given article
  def destroy
    if @article.destroy
      redirect_to articles_path, notice: 'Article was successfully deleted.'
    else
      render :show
    end
  end
  
  private
  
  # Sets the current article using the ID parameter 
  def set_article
    @article = Article.find_by(id: params[:id])
    # If the requested article is not found, redirects to the articles index page and display a message
    redirect_to articles_path, notice: 'The article you requested was not found, it may have been deleted' if @article.nil?
  end
  
  # Required parameters for creating/updating articles
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
