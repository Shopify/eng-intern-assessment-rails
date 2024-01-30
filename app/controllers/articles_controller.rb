class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  # searches for an article
  def search
    @articles = if params[:q]
      Article.search(params[:q])
    end
  end

  # show a single article
  def show
    @article = Article.find(params[:id])
  end

  # create a new article
  def new
    @article = Article.new
  end

  # post a new article
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

  # updates existing article
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # destroys an article
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
