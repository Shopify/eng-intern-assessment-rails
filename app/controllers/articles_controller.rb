class ArticlesController < ApplicationController
  def index # get all articles
    @articles = Article.all
  end

  def show # show a single article
    @article = Article.find(params[:id])
  end

  def new # initialize a new article
    @article = Article.new
  end

  def create # post a new article to the DB
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit # find an article in the DB
    @article = Article.find(params[:id])
  end

  def update # update an existing article
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # delete an existing article
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  def search # search for articles
    if params[:query].present?
      @articles = Article.search(params[:query])
    else
      @articles = Article.none
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
