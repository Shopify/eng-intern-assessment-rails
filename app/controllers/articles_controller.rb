# frozen_string_literal: true

# The ArticlesController handles requests for the Article model.
# This controller is responsible for creating new articles, displaying existing articles, searching for articles,
# and deleting articles.
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find_by(id: params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find_by(id: params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # GET /article/new
  def new
    @article = Article.new
  end

  # POST /article
  def create
    @article = Article.new(article_params)

    if @article.valid? && @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])
    @article.destroy

    redirect_to articles_path, notice: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
