class ArticlesController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @query = params[:q]
    @page = params[:page]
    @articles = Rails.cache.fetch("articles_#{@query}_#{@page}", expires_in: 1.hour) do
      Article.search(@query, @page)
    end
  end

  def show
    @article = Rails.cache.fetch("article_#{params[:id]}", expires_in: 1.hour) do
      Article.find(params[:id])
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(permitted_article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(permitted_article_params)
      Rails.cache.write("article_#{params[:id]}", @article, expires_in: 1.hour)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    Rails.cache.delete("article_#{params[:id]}")
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully deleted.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def permitted_article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
