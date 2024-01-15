class ArticlesController < ApplicationController
  # Display articles
  # If article_search query is present, filter the article search otherwise return all articles
  def index
    if params[:article_search_query]
      @articles = Article.search(params[:article_search_query])
    else
      @articles = Article.all
    end
  end

  # Given an ID, Display a certain article
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  # Create a new article
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  # Update an existing article otherwise redirect to error
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

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

