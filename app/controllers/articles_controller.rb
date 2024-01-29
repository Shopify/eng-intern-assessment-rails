# frozen_string_literal: true

# The ArticlesController handles requests for the Article model.
# This controller is responsible for creating new articles, displaying existing articles, searching for articles,
# and deleting articles.
class ArticlesController < ApplicationController

  # GET /article
  def index
    @articles = Article.all
  end

  # GET /article/:id
  def show
    @article = Article.find_by(id: params[:id])
  end

  # GET /article/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH/PUT /article/:id
  def update
    @article = Article.find_by(id: params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated'
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
      redirect_to @article, notice: 'Article was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /article/:id
  def destroy
    @article = Article.find_by(id: params[:id])
    @article.destroy

    redirect_to articles_path, notice: 'Article was successfully destroyed'
  end

  private

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
