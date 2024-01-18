class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order('created_at DESC')
  end

  def show
    set_article
  end

  def new
    @article = Article.new
  end

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

  def update
    set_article

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_article
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
