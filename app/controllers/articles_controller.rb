class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
      @article = Article.new(article_params)

      if @article.save
        redirect_to articles_path, notice: 'Article was successfully created.'
      else
        render :new
      end
  end

  def edit
    render '_form'
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully destroyed.'
  end

  def search
    @articles = Article.search(params[:query])
    render :index, status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
