class ArticlesController < ApplicationController
  def index
    if params[:search].present?
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    build_author
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      build_author
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    build_author
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      build_author
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
      params.require(:article).permit(:title, :content, :date, author_attributes: [:name])
    end

    def build_author
      unless @article.author.present?
        @article.build_author
      end
    end
end
