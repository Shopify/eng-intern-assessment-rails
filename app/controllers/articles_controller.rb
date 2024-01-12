class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @page = params.fetch(:page, 0).to_i
    per_page = 3  # Number of articles per page
  
    if params[:query].present?
      @articles = Article.search(params[:query]).limit(per_page).offset(@page * per_page)
    else
      @articles = Article.limit(per_page).offset(@page * per_page)
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
  
  def update
    if @article.update(article_params)
    redirect_to @article, notice: 'Article was successfully updated.'
    else
    render :edit
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully deleted.'
  end
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
