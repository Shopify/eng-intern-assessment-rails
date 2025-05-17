class ArticlesController < ApplicationController

  # GET /articles
  # Displays search results if search parameter present, otherwise displays list of all articles
  def index
    @articles = params[:search] ? Article.search(params[:search]) : Article.all
  end

  # GET /articles/:id
  # Redirects user to page for the article with the given id
  def show
    @article = Article.find(params[:id])
    redirect_to articles_path, alert: 'Invalid search query' if @article.nil?
  end

  # GET /articles/new
  # Redirects to form for adding new article
  def new
    @article = Article.new
  end

  # POST /articles
  # New article created with given information and redirects to article's page if successful
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article created.'
    else
      render :new
    end
  end


  # GET /articles/:id/edit
  # Redirects to form for editing the article's fields
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH /articles/:id
  # updates the article's fields, redirects to now-edited article if successful
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: 'Article updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/:id
  # deletes the article with the given id and redirects to homepage
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_url, notice: 'Article removed.'
  end

  private

  # Strong parameters, for when new articles are added or existing articles are updated.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

end
