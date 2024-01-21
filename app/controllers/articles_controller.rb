# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.search(params[:search])
  end

  def show
    # @article is set by set_article
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to(@article, notice: "Article was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
    # @article is set by set_article
  end

  def update
    if @article.update(article_params)
      redirect_to(@article, notice: "Article was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @article.destroy
    redirect_to(articles_url, notice: "Article was successfully deleted.")
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
