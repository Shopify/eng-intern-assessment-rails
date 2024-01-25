class ArticlesController < ApplicationController
  #set_article is a method that is called before the show, edit, update and destroy actions for readability and time saving purposes.
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  #if there is a search parameter, the search method is called, else all articles are shown.
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  def show
    if @article.nil?
      redirect_to articles_path, notice: 'Article not found'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
