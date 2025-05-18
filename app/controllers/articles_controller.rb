class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # Retrieves all articles and assigns them to @articles for the view.
  def index
    @articles = Article.all
  end

  # Initializes a new article instance for the form helper in the 'new' view.
  def new
    @article = Article.new
  end

  # Attempts to save a new Article instance from form parameters.
  # Redirects to the article's show page on success, or renders the 'new' view again on failure.
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # Retrieves an existing article to edit using the ID from the URL parameters.
  def edit
    @article = Article.find(params[:id])
  end

  # Retrieves an article to display on its show page.
  # If the article does not exist, redirects to the articles index with an alert.
  def show
    @article = Article.find_by(id: params[:id])
    redirect_to articles_path, alert: 'Article not found' if @article.nil?
  end

  # Updates an existing article with form parameters.
  # Redirects to the article's show page on success, or renders the 'edit' view again on failure.
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # Deletes an article and redirects to the articles index with a success notice.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully deleted.'
  end

  # Searches for articles that match a given query.
  # If no articles are found, sets an alert flash message.
  # If exactly one article is found, redirects to that article's show page.
  # Otherwise, displays all matching articles in the index view.
  def search
    Rails.logger.debug "Search query: #{params[:query]}"

    @articles = Article.search(params[:query])
    Rails.logger.debug "Number of articles found: #{@articles.size}"

    if @articles.empty?
      flash.now[:alert] = 'No articles found'
    elsif @articles.length == 1
      redirect_to article_path(@articles.first) and return
    end

    render :index
  end

  private
  #Helps handle errors
  def set_article
    @article = Article.find_by(id: params[:id])
    redirect_to articles_path, alert: 'Article not found' unless @article
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)  # Added :date to permitted params
  end
end
