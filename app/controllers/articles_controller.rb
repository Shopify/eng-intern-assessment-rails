class ArticlesController < ApplicationController
  def index #index route provides search functionality
    @articles = Article.search(params[:search])
  end

  def show #implement error handling if article not found?
    @article = Article.find(params[:id])
  end

  def new #implement error handling if article not found?
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.date = Date.today

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
