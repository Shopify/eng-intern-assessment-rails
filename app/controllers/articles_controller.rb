class ArticlesController < ApplicationController

  def index
    @articles = params[:search] ? Article.search(params[:search]) : Article.all
  end

  def show
    @article = Article.find(params[:id])
    redirect_to articles_path, alert: 'Invalid search query' if @article.nil?
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article created.'
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: 'Article updated.'
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_url, notice: 'Article removed.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

end
