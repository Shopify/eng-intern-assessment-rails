class ArticlesController < ApplicationController
  def index
    @articles = Article.all

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(title: "...", content: "...", author: "...", date: "...")

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity

end
