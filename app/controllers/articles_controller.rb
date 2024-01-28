# frozen_string_literal: true

# The ArticlesController handles requests for the Article model.
# This controller is responsible for creating new articles, displaying existing articles, searching for articles,
# and deleting articles.
class ArticlesController < ApplicationController
  def search; end

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find_by(id: params[:id])
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

  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
