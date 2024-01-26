# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def index
    @articles = Article.all
  end

  def show
    # @article is already set by the before_action
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article created.'
    else
      render :new
    end
  end

  def edit
    # @article is already set by the before_action
  end

  def update
    if @article.update(article_params)
      p article_params
      redirect_to @article, notice: 'Article updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path, notice: 'Article deleted.'
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
