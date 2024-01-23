# frozen_string_literal: true

# Controller for managing and displaying articles in the virtual encyclopedia.
class ArticlesController < ApplicationController
  def index
    @articles = if params[:search].present?
                  Article.search(params[:search])
                else
                  Article.all
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

    redirect_to articles_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :date, author_attributes: [:name])
  end

  def build_author
    return if @article.author.present?

    @article.build_author
  end
end
