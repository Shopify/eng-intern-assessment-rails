# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  before_action :set_article_service, only: [:index, :show, :new, :create, :edit, :update, :destroy, :search]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = @article_service.get_all_articles
  end

  def new
    @article = Domain::Article.new
  end

  def show
    @article
  end

  def edit
  end

  def create
    @article = @article_service.create_article(article_params)
    redirect_to article_url(@article.id), notice: "Article was successfully created."
  end

  def update
    if @article_service.update_article(@article, article_params)
      redirect_to article_url(@article.id), notice: "Article was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @article_service.destroy_article(@article)
    redirect_to articles_path, notice: "Article was successfully destroyed."
  end

  def search
    @articles = @article_service.search_articles(params[:query])
  end

  private

  def set_article
    article_record = @article_service.find_article(params[:id])
    @article = article_record
  end

  def set_article_service
    @article_service = Services::ArticleService.new(
      Repositories::Article::SqliteArticleRepository.new
    )
  end

  def article_params
    params.require(:domain_article).permit(:author, :title, :content, :date)
  end
end
