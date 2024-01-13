class ArticlesController < ApplicationController
  # view and search articles
  def index
    @articles = Article.all

    if params[:article_search] && params[:article_search] != ""
      @articles = Article.search(params[:article_search])
    end
  end

  # get article by id
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  # create, save a new article
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

  # update, save an article
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # delete article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end