require 'net/http'
require 'uri'
require 'json'

class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
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

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, status: :see_other
    else
      render :error, status: :unprocessable_entity
      redirect_to articles_path, status: :unprocessable_entity
    end
  end

  def search
    @search_results = Article.search(params[:query], params[:type])
    @articles = Article.all
    render 'index'
  end

  private
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def record_not_found
      flash[:alert] = "Article not found."
      redirect_to articles_path
    end


end
