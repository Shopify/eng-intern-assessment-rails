class ArticlesController < ApplicationController
  def index
    @articles = Article.all

    if params[:query] != ""
      @articles = Article.search(params[:query])
    end
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def search
    @article = Article.find(params[:query])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.date = Time.now

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

    redirect_to articles_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :author, :content)
    end
end
