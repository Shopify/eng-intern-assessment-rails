class ArticlesController < ApplicationController
  # Get a list of articles.
  # If article_search query is present, filter the article search, otherwise return all articles.
  def index
    if params[:article_search_query]
      @articles = Article.search(params[:article_search_query])
    else
      @articles = Article.all
    end
  end

  # Get article by id.
  def show
    @article = Article.find(params[:id])
  end

  # Create an empty instantiation of a Article object.
  # Used when creating a Article with a form.
  def new
    @article = Article.new
  end

  # Create a new article object and save it to the database.
  # Upon successful save, redirect to specified Article, otherwise display error message.
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Find Article with specified id.
  # Used when editing a Article with a form.
  def edit
    @article = Article.find(params[:id])
  end

  # Update an existing article.
  # Upon successful save, redirect to specified Article, otherwise display error message.
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Delete an existing article
  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end

