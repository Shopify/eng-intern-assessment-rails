class ArticlesController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show; end

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
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully deleted.'
  end

  def search
    @query = params[:q]
    @articles = Article.search(@query)
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def permitted_article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
